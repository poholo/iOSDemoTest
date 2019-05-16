
#include <stdlib.h>
#include <stdio.h>
#include <string.h>

#include <libavcodec/avcodec.h>
#include <libavformat/avformat.h>

FILE *pfout = NULL;
char ffrvout[128] = {0};

#define FRAME_NUM 1
#define ENABLE_YUV_SAVE
#define ENABLE_PRINT_FRAME_BYTES
#define PRINT_BYTES 30

/**
 * save yuv420p frame [YUV]
 */
void yuv420p_save(AVFrame *pFrame, AVCodecContext *pCodecCtx) {
    int i = 0;

    int width = pCodecCtx->width, height = pCodecCtx->height;
    int height_half = height / 2, width_half = width / 2;
    int y_wrap = pFrame->linesize[0];
    int u_wrap = pFrame->linesize[1];
    int v_wrap = pFrame->linesize[2];

    unsigned char *y_buf = pFrame->data[0];
    unsigned char *u_buf = pFrame->data[1];
    unsigned char *v_buf = pFrame->data[2];

    //save y
    for (i = 0; i < height; i++)
        fwrite(y_buf + i * y_wrap, 1, width, pfout);
    fprintf(stderr, "===>save Y success\n");
    //save u
    for (i = 0; i < height_half; i++)
        fwrite(u_buf + i * u_wrap, 1, width_half, pfout);
    fprintf(stderr, "===>save U success\n");
    //save v
    for (i = 0; i < height_half; i++)
        fwrite(v_buf + i * v_wrap, 1, width_half, pfout);
    fprintf(stderr, "===>save V success\n");

    fflush(pfout);
}

/**
 * save yuv422p frame [YUV]
 */
void yuv422p_save(AVFrame *pFrame, AVCodecContext *pCodecCtx) {
    int i = 0;

    int width = pCodecCtx->width, height = pCodecCtx->height;
    int height_half = height / 2, width_half = width / 2;
    int y_wrap = pFrame->linesize[0];
    int u_wrap = pFrame->linesize[1];
    int v_wrap = pFrame->linesize[2];

    unsigned char *y_buf = pFrame->data[0];
    unsigned char *u_buf = pFrame->data[1];
    unsigned char *v_buf = pFrame->data[2];

    //save y
    for (i = 0; i < height; i++)
        fwrite(y_buf + i * y_wrap, 1, width, pfout);
    fprintf(stderr, "===>save Y success\n");
    //save u
    for (i = 0; i < height; i++)
        fwrite(u_buf + i * u_wrap, 1, width_half, pfout);
    fprintf(stderr, "===>save U success\n");
    //save v
    for (i = 0; i < height; i++)
        fwrite(v_buf + i * v_wrap, 1, width_half, pfout);
    fprintf(stderr, "===>save V success\n");

    fflush(pfout);
}

/**
 * save rgb24 frame [PPM]
 */
void rgb24_save(AVFrame *pFrame, AVCodecContext *pCodecCtx) {
    int i = 0;
    int width = pCodecCtx->width, height = pCodecCtx->height;

    /* write PPM header */
    fprintf(pfout, "P6\n%d %d\n255\n", width, height);

    /* write pixel data */
    for (i = 0; i < height; i++)
        fwrite(pFrame->data[0] + i * pFrame->linesize[0], 1, width * 3, pfout);

    fflush(pfout);
}

/**
 * save yuv444p frame [YUV]
 */
void yuv444p_save(AVFrame *pFrame, AVCodecContext *pCodecCtx) {
    int i = 0;

    int width = pCodecCtx->width, height = pCodecCtx->height;
    int y_wrap = pFrame->linesize[0];
    int u_wrap = pFrame->linesize[1];
    int v_wrap = pFrame->linesize[2];

    unsigned char *y_buf = pFrame->data[0];
    unsigned char *u_buf = pFrame->data[1];
    unsigned char *v_buf = pFrame->data[2];

    //save y
    for (i = 0; i < height; i++)
        fwrite(y_buf + i * y_wrap, 1, width, pfout);
    fprintf(stderr, "===>save Y success\n");
    //save u
    for (i = 0; i < height; i++)
        fwrite(u_buf + i * u_wrap, 1, width, pfout);
    fprintf(stderr, "===>save U success\n");
    //save v
    for (i = 0; i < height; i++)
        fwrite(v_buf + i * v_wrap, 1, width, pfout);
    fprintf(stderr, "===>save V success\n");

    fflush(pfout);
}

int main(int argc, char *argv[]) {
    int i;
    char szFileName[128] = {0};
    int decLen = 0;
    int frame = 0;
    AVCodecContext *pCodecCtx = NULL;
    AVFrame *pFrame = NULL;
    AVCodec *pCodec = NULL;
    AVFormatContext *pFormatCtx = NULL;
    if (argc != 3) {
        fprintf(stderr, "ERROR:need 3 argument!\n");
        exit(-1);
    }

    sprintf(szFileName, "%s", argv[1]);

#ifdef ENABLE_DEMUX_SAVE
    FILE* frvdemux = fopen("rvdemuxout.rm","wb+");
    if (NULL == frvdemux)
    {
        fprintf(stderr, "create rvdemuxout file failed\n");
        exit(1);
    }
#endif

    /* output yuv file name */
    sprintf(ffrvout, "%s", argv[2]);

    pfout = fopen(ffrvout, "wb+");
    if (NULL == pfout) {
        printf("create output file failed\n");
        exit(1);
    }
    printf("==========> Begin test ffmpeg call ffmpeg rv decoder\n");
    av_register_all();

    /* Open input video file */
    //printf("before avformat_open_input [%s]\n", szFileName);
    if (avformat_open_input(&pFormatCtx, szFileName, NULL, NULL) != 0) {
        fprintf(stderr, "Couldn't open input file\n");
        return -1;
    }
    //printf("after avformat_open_input\n");

    /* Retrieve stream information */
    if (av_find_stream_info(pFormatCtx) < 0) {
        printf("av_find_stream_info ERROR\n");
        return -1;
    }
    //printf("after av_find_stream_info, \n");


    /* Find the first video stream */
    int videoStream = -1;
    printf("==========> pFormatCtx->nb_streams = %d\n", pFormatCtx->nb_streams);

    for (i = 0; i < pFormatCtx->nb_streams; i++) {
        if (pFormatCtx->streams[i]->codec->codec_type == AVMEDIA_TYPE_VIDEO) {
            videoStream = i;
            printf("the first video stream index: videoStream = %d\n", videoStream);
            break;
        }
    }

    if (videoStream == -1)
        return -1;        // Didn't find a video stream

    /* Get a pointer to the codec context for the video stream */
    pCodecCtx = pFormatCtx->streams[videoStream]->codec;
    printf("pCodecCtx->codec_id = %d\n", pCodecCtx->codec_id);

    pCodec = avcodec_find_decoder(pCodecCtx->codec_id);
    if (pCodec == NULL) {
        fprintf(stderr, "can not find decoder!\n");
        return -1;
    }

    /* Open codec */
    if (avcodec_open(pCodecCtx, pCodec) < 0) {
        printf("cannot open software codec\n");
        return -1; // Could not open codec
    }
    printf("==========> Open software codec success\n");

    pFrame = avcodec_alloc_frame();
    if (pFrame == NULL) {
        fprintf(stderr, "avcodec_alloc_frame() ERROR\n");
        return -1;
    }

    /* flag whether we get a decoded yuv frame */
    int frameFinished;
    int packetno = 0;

    AVPacket packet;
    av_init_packet(&packet);

    while (av_read_frame(pFormatCtx, &packet) >= 0) {
        //printf("[main]avpkt->slice_count=%d\n", packet.sliceNum);

        /* Is this a packet from the video stream? */
        if (packet.stream_index == videoStream) {
            packetno++;
#ifdef ENABLE_PRINT_FRAME_BYTES
            if (1) {
                int i;
                int size = packet.size < PRINT_BYTES ? packet.size : PRINT_BYTES;
                unsigned char *data = packet.data;
                printf("===>[%5d] [", packet.size);
                for (i = 0; i < size; i++)
                    printf("%02x ", data[i]);
                printf("]\n");
            }
#endif
#ifdef ENABLE_DEMUX_SAVE
            fwrite(packet.data, 1, packet.size, frvdemux);
#endif
            //printf("[the %d packet]packet.size = %d\n", packetno++, packet.size);

            while (packet.size > 0) {
                decLen = avcodec_decode_video2(pCodecCtx, pFrame, &frameFinished, &packet);
                //printf("[video_decode_example]after avcodec_decode_video2,decoded=%d\n",decLen);

                if (decLen < 0) {
                    fprintf(stderr, "[video_decode_example]Error while decoding frame %d\n", frame);
                    //exit(1);
                    /* FIXME if decode one frame err, ignore this frame */
                    decLen = packet.size;
                }

                if (frameFinished) {
                    printf("got a yuv frame\n");
                    //printf(stderr, "[video_decode_example]saving frame %3d\n", frame);

                    /* the picture is allocated by the decoder. no need to free it */
                    if (frame == 0) {
                        printf("[video_decode_example]picture->linesize[0]=%d, c->width=%d,c->height=%d\n",
                                pFrame->linesize[0], pCodecCtx->width, pCodecCtx->height);
                        printf("===>YUV format = %d\n", pFrame->format);
                    }
#ifdef ENABLE_YUV_SAVE
                    /* save yuv pic */
                    if (frame < FRAME_NUM) {
                        switch (pFrame->format) {
                            case 0 :    /* YUV420P */
                                yuv420p_save(pFrame, pCodecCtx);
                                break;
                            case 2 :    /* RGB24 */
                                rgb24_save(pFrame, pCodecCtx);
                                break;
                            case 13 :    /* YUVJ422P */
                                yuv422p_save(pFrame, pCodecCtx);
                                break;
                            case 14 :    /* YUVJ444P */
                                yuv444p_save(pFrame, pCodecCtx);
                                break;
                            default :
                                fprintf(stderr, "unsupport YUV format for saving\n");
                                break;
                        }
                        fprintf(stderr, "===>save pic success\n");
                    }
#endif
                    /* frame index grow */
                    frame++;
                }
                //printf("===========> %d\n", decLen);
                /* left data in pkt , go on decoding */
                packet.data += decLen;
                packet.size -= decLen;
            }
            if (frame == FRAME_NUM) {
                printf("==========> decoded [%d pkt frames] ---> save [%d YUV frames], enough to stop!\n", packetno, FRAME_NUM);
                break;
            }
        }

        /* FIXME no need free in this file */
        //printf("free packet that was allocated by av_read_frame\n");
        // Free the packet that was allocated by av_read_frame
        //av_free_packet(&packet);
    }

    printf("decoding job down! begin to free\n");
    /* Free the YUV frame */
    av_free(pFrame);

    /* Close the codec */
    avcodec_close(pCodecCtx);

    /* Close the video file */
    av_close_input_file(pFormatCtx);
    fclose(pfout);

    printf("==========> END-OK\n");

    return 0;

}
