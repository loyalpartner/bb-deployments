local common = import 'common.libsonnet';

{
  blobstore: common.blobstore,
  browserUrl: common.browserUrl,
  maximumMessageSizeBytes: common.maximumMessageSizeBytes,
  scheduler: { address: 'localhost:8983' },
  maximumMemoryCachedDirectories: 1000,
  global: common.globalWithDiagnosticsHttpServer(':9986'),
  buildDirectories: [{
    native: {
      buildDirectoryPath: std.extVar('PWD') + '/worker/build',
      cacheDirectoryPath: 'worker/cache',
      maximumCacheFileCount: 10000,
      maximumCacheSizeBytes: 1024 * 1024 * 1024,
      cacheReplacementPolicy: 'LEAST_RECENTLY_USED',
    },
    runners: [{
      # https://github.com/grpc/grpc/blob/master/doc/naming.md
      endpoint: { address: 'unix:worker/runner' },
      concurrency: 8,
      platform: {
        properties: [
          { name: 'OSFamily', value: 'Linux' },
          /* { name: 'container-image', value: 'docker://marketplace.gcr.io/google/rbe-ubuntu16-04@sha256:b516a2d69537cb40a7c6a7d92d0008abb29fba8725243772bdaf2c83f1be2272' } */
        ],
      },
      workerId: {
        datacenter: 'paris',
        rack: '4',
        slot: '15',
        hostname: 'ubuntu-worker.example.com',
      },
    }],
  }],
  outputUploadConcurrency: 11,
}
