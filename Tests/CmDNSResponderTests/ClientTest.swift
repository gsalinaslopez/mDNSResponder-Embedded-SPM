import Testing

@testable import CmDNSResponder

// manually copy .h files from Sources/CmDNSResponder into Sources/CmDNSResponder/include
// so it can become available when importing the whole module
nonisolated(unsafe)
  var mDNSStorage = mDNS()

nonisolated(unsafe)
  var PlatformStorage = mDNS_PlatformSupport()

@Test func something() {
  let RR_CACHE_SIZE: mDNSu32 = 500
  var gRRCache = [CacheEntity](repeating: CacheEntity(), count: Int(RR_CACHE_SIZE))
  var status: mStatus? = nil
  withUnsafeMutablePointer(to: &mDNSStorage) { mDNSStoragePtr in
    withUnsafeMutablePointer(to: &PlatformStorage) { PlatformStoragePtr in
      var status: mStatus = mDNS_Init(
        mDNSStoragePtr, PlatformStoragePtr,
        &gRRCache, RR_CACHE_SIZE,
        0, nil, nil
      )
      print(status == mStatus_NoError)
      if (status == mStatus_NoError) {
        var type = domainname()
        var domain = domainname()
        var gServiceType = Array("_afpovertcp._tcp".utf8CString)//CChar(" ")
        var gServiceDomain = Array("local.".utf8CString)//CChar(" ")
        

        MakeDomainNameFromDNSNameString(&type, &gServiceType)
        MakeDomainNameFromDNSNameString(&domain, &gServiceDomain)

        var question = DNSQuestion()

        func BrowseCallback(_ m: UnsafeMutablePointer<mDNS_struct>?, _ question: UnsafeMutablePointer<DNSQuestion_struct>?, _ answer: UnsafePointer<ResourceRecord_struct>?, _ AddRecord: QC_result) {

        }
        status = mDNS_StartBrowse(mDNSStoragePtr, &question, &type, &domain, mDNSInterface_Any, 0, mDNSBool(mDNSfalse), mDNSBool(mDNSfalse), BrowseCallback, nil)
        print(status)
        print(status == mStatus_NoError)
        if (status == mStatus_NoError) {

        }
      }
    }
  }
}
/*
int main(int argc, char **argv)
// The program's main entry point.  The program does a trivial
// mDNS query, looking for all AFP servers in the local domain.
{
    int result;
    mStatus status;
    DNSQuestion question;
    domainname type;
    domainname domain;

    // Parse our command line arguments.  This won't come back if there's an error.
    ParseArguments(argc, argv);

    // Initialise the mDNS core.
    status = mDNS_Init(&mDNSStorage, &PlatformStorage,
                       gRRCache, RR_CACHE_SIZE,
                       mDNS_Init_DontAdvertiseLocalAddresses,
                       mDNS_Init_NoInitCallback, mDNS_Init_NoInitCallbackContext);
    if (status == mStatus_NoError) {

        // Construct and start the query.

        MakeDomainNameFromDNSNameString(&type, gServiceType);
        MakeDomainNameFromDNSNameString(&domain, gServiceDomain);

        status = mDNS_StartBrowse(&mDNSStorage, &question, &type, &domain, mDNSInterface_Any, 0, mDNSfalse, mDNSfalse, BrowseCallback, NULL);

        // Run the platform main event loop until the user types ^C.
        // The BrowseCallback routine is responsible for printing
        // any results that we find.

        if (status == mStatus_NoError) {
            fprintf(stderr, "Hit ^C when you're bored waiting for responses.\n");
            ExampleClientEventLoop(&mDNSStorage);
            mDNS_StopQuery(&mDNSStorage, &question);
            mDNS_Close(&mDNSStorage);
        }
    }

    if (status == mStatus_NoError) {
        result = 0;
    } else {
        result = 2;
    }
    if ( (result != 0) || (gMDNSPlatformPosixVerboseLevel > 0) ) {
        fprintf(stderr, "%s: Finished with status %d, result %d\n", gProgramName, (int)status, result);
    }

    return 0;
}
*/
