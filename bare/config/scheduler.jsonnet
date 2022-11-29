local common = import 'common.libsonnet';

{
  adminHttpListenAddress: ':7982',
  clientGrpcServers: [{
    listenAddresses: ['0.0.0.0:8982'],
    authenticationPolicy: { allow: {} },
  }],
  workerGrpcServers: [{
    listenAddresses: ['0.0.0.0:8983'],
    authenticationPolicy: { allow: {} },
  },{
    listenAddresses: ['0.0.0.0:8984'],
    authenticationPolicy: { allow: {} },
  },{
    listenAddresses: ['0.0.0.0:8985'],
    authenticationPolicy: { allow: {} },
  }],
  browserUrl: common.browserUrl,
  contentAddressableStorage: common.blobstore.contentAddressableStorage,
  maximumMessageSizeBytes: common.maximumMessageSizeBytes,
  global: common.globalWithDiagnosticsHttpServer(':9982'),
  executeAuthorizer: { allow: {} },
  actionRouter: {
    simple: {
      platformKeyExtractor: { actionAndCommand: {} },
      invocationKeyExtractors: [
        { correlatedInvocationsId: {} },
        { toolInvocationId: {} },
      ],
      initialSizeClassAnalyzer: {
        defaultExecutionTimeout: '1800s',
        maximumExecutionTimeout: '7200s',
      },
    },
  },
  platformQueueWithNoWorkersTimeout: '900s',
}
