/*
 File: MainViewController.m
 Abstract:
 This is the main view controller of the application.  It manages a iOS Messages like table view.  There are buttons for browsing for nearby peers and showing the a utility page. The table view data source is an array of Transcript objects which are created when sending or receving data (or image resources) via the MultipeerConnectivity data APIs.
 
 Version: 1.0
 
 Disclaimer: IMPORTANT:  This Apple software is supplied to you by Apple
 Inc. ("Apple") in consideration of your agreement to the following
 terms, and your use, installation, modification or redistribution of
 this Apple software constitutes acceptance of these terms.  If you do
 not agree with these terms, please do not use, install, modify or
 redistribute this Apple software.
 
 In consideration of your agreement to abide by the following terms, and
 subject to these terms, Apple grants you a personal, non-exclusive
 license, under Apple's copyrights in this original Apple software (the
 "Apple Software"), to use, reproduce, modify and redistribute the Apple
 Software, with or without modifications, in source and/or binary forms;
 provided that if you redistribute the Apple Software in its entirety and
 without modifications, you must retain this notice and the following
 text and disclaimers in all such redistributions of the Apple Software.
 Neither the name, trademarks, service marks or logos of Apple Inc. may
 be used to endorse or promote products derived from the Apple Software
 without specific prior written permission from Apple.  Except as
 expressly stated in this notice, no other rights or licenses, express or
 implied, are granted by Apple herein, including but not limited to any
 patent rights that may be infringed by your derivative works or by other
 works in which the Apple Software may be incorporated.
 
 The Apple Software is provided by Apple on an "AS IS" basis.  APPLE
 MAKES NO WARRANTIES, EXPRESS OR IMPLIED, INCLUDING WITHOUT LIMITATION
 THE IMPLIED WARRANTIES OF NON-INFRINGEMENT, MERCHANTABILITY AND FITNESS
 FOR A PARTICULAR PURPOSE, REGARDING THE APPLE SOFTWARE OR ITS USE AND
 OPERATION ALONE OR IN COMBINATION WITH YOUR PRODUCTS.
 
 IN NO EVENT SHALL APPLE BE LIABLE FOR ANY SPECIAL, INDIRECT, INCIDENTAL
 OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
 SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
 INTERRUPTION) ARISING IN ANY WAY OUT OF THE USE, REPRODUCTION,
 MODIFICATION AND/OR DISTRIBUTION OF THE APPLE SOFTWARE, HOWEVER CAUSED
 AND WHETHER UNDER THEORY OF CONTRACT, TORT (INCLUDING NEGLIGENCE),
 STRICT LIABILITY OR OTHERWISE, EVEN IF APPLE HAS BEEN ADVISED OF THE
 POSSIBILITY OF SUCH DAMAGE.
 
 Copyright (C) 2013 Apple Inc. All Rights Reserved.
 
 */


/**
 *
 1. Init
 SettingsViewController *viewController = (SettingsViewController *)navController.topViewController;
 viewController.delegate = self;
 // Pass the existing properties (if any) so the user can edit them.
 viewController.displayName = self.displayName;
 viewController.serviceType = self.serviceType;
 [self createSession];
 
 2. Send Message
 Transcript *transcript = [self.sessionContainer sendMessage:self.messageComposeTextField.text];
 
 3. Read Message
 - (void)receivedTranscript:(Transcript *)transcript
 
 4. Update Transcript
 - (void)updateTranscript:(Transcript *)transcript
 */
 

@import MultipeerConnectivity;

#import "PeerConnect.h"
#import "SessionContainer.h"
#import "Transcript.h"

@interface PeerConnect () <SessionContainerDelegate>

@property (nonatomic, assign) BOOL started;
// MC Session for managing peer state and send/receive data between peers
@property (retain, nonatomic) SessionContainer *sessionContainer;
// TableView Data source for managing sent/received messagesz
// Map of resource names to transcripts array index
@property (retain, nonatomic) NSMutableDictionary *imageNameIndex;
// Text field used for typing text messages to send to peers
// Button for executing the message send.

@end

@implementation PeerConnect

#pragma mark - Override super class methods

- (void)serviceStart
{
    
    _transcripts = [NSMutableArray new];
    _imageNameIndex = [NSMutableDictionary new];
    _started=true;
    
    
    [self createSession];
    
    [self performSelectorInBackground:@selector(loop) withObject:nil];
    
}

- (void)stop{
    _started = false;
}

- (void)loop
{
    while (_started) {
        usleep(200000);
    }
}

- (void)sendText:(NSString *)txt
{
    Transcript *transcript = [self.sessionContainer sendMessage:txt];
    NSLog(@"%@", transcript.description);
}



#pragma mark - SessionContainerDelegate

- (void)receivedTranscript:(Transcript *)transcript
{
    // Add to table view data source and update on main thread
    dispatch_async(dispatch_get_main_queue(), ^{
        [self insertTranscript:transcript];
        [_messageDelegate didReceiveTranscript:transcript];
    });
}

- (void)updateTranscript:(Transcript *)transcript
{
    // Find the data source index of the progress transcript
    NSNumber *index = [_imageNameIndex objectForKey:transcript.imageName];
    NSUInteger idx = [index unsignedLongValue];
    // Replace the progress transcript with the image transcript
    [_transcripts replaceObjectAtIndex:idx withObject:transcript];
    
    // Reload this particular table view row on the main thread
    dispatch_async(dispatch_get_main_queue(), ^{
        //NSIndexPath *newIndexPath = [NSIndexPath indexPathForRow:idx inSection:0];
    });
}

#pragma mark - private methods

// Private helper method for the Multipeer Connectivity local peerID, session, and advertiser.  This makes the application discoverable and ready to accept invitations
- (void)createSession
{
    // Create the SessionContainer for managing session related functionality.
    self.sessionContainer = [[SessionContainer alloc] initWithDisplayName:HOST_ID serviceType:ROOM_ID];
    // Set this view controller as the SessionContainer delegate so we can display incoming Transcripts and session state changes in our table view.
    _sessionContainer.delegate = self;
}

// Helper method for inserting a sent/received message into the data source and reload the view.
// Make sure you call this on the main thread
- (void)insertTranscript:(Transcript *)transcript
{
    // Add to the data source
    [_transcripts addObject:transcript];
    
    // If this is a progress transcript add it's index to the map with image name as the key
    if (nil != transcript.progress) {
        NSNumber *transcriptIndex = [NSNumber numberWithUnsignedLong:(_transcripts.count - 1)];
        [_imageNameIndex setObject:transcriptIndex forKey:transcript.imageName];
    }
    
}

@end
