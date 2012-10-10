/*
 # MagneticNSWindow - Make any NSWindow Magnetic!
 # Copyright (C) 2009-2012 Shmoopi LLC <shmoopillc@gmail.com> <http://www.shmoopi.net/>
 #
 # BSD License
 # Redistribution and use in source and binary forms, with or without
 # modification, are permitted provided that the following conditions are met:
 #     * Redistributions of source code must retain the above copyright
 #       notice, this list of conditions and the following disclaimer.
 #     * Redistributions in binary form must reproduce the above copyright
 #       notice, this list of conditions and the following disclaimer in the
 #       documentation and/or other materials provided with the distribution.
 #     * Neither the name of Shmoopi LLC nor that of any other
 #       contributors may be used to endorse or promote products
 #       derived from this software without specific prior written permission.
 #
 # THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
 # ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
 # WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
 # DISCLAIMED. IN NO EVENT SHALL  BE LIABLE FOR ANY
 # DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
 # (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
 # LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
 # ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
 # (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
 # SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 */


@implementation MagneticNSWindow

// Set up the NSWindow Delegate in the .h
<NSWindowDelegate>

// Application just started
- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    // Insert code here to initialize your application
    
    // Set up the window delegate
    self.window.delegate = self;
    
}

// Magnetic Window
- (void)windowDidMove:(NSNotification *)notification {
    if (self.window.isVisible == true) {
        NSEnumerator *e;
        NSWindow *theWindow;
        id edgeObject;
        NSArray *frames = [[NSApp windows] arrayByAddingObjectsFromArray:[NSScreen screens]];
        NSRect frame, myFrame;
        BOOL hDidChange = NO, vDidChange = NO;
        float gravity = 46.0;
        
        theWindow = [notification object];
        myFrame = [theWindow frame];
        e = [frames objectEnumerator];
        
        if ([[NSApp currentEvent] modifierFlags] & NSAlternateKeyMask) return;
        
        while (edgeObject = [e nextObject]) {
            if ((edgeObject != theWindow && ([edgeObject respondsToSelector:@selector(isVisible)] && [edgeObject isVisible])) || [edgeObject isKindOfClass:[NSScreen class]]) {
                frame = [edgeObject frame];
                
                // horizontal magnet /
                if (!hDidChange && fabs(NSMinX(frame) - NSMinX(myFrame)) <= gravity) {
                    //NSLog(@"NSMinX(frame) - NSMinX(myFrame)");
                    myFrame.origin.x = frame.origin.x;
                    hDidChange = YES;
                } if (!hDidChange && fabs(NSMinX(frame) - NSMaxX(myFrame)) <= gravity) {
                    //NSLog(@"NSMinX(frame) - NSMaxX(myFrame)");
                    myFrame.origin.x += NSMinX(frame) - NSMaxX(myFrame);
                    hDidChange = YES;
                } if (!hDidChange && fabs(NSMaxX(frame) - NSMinX(myFrame)) <= gravity) {
                    //NSLog(@"NSMaxX(frame) - NSMinX(myFrame)");
                    myFrame.origin.x = NSMaxX(frame);
                    hDidChange = YES;
                } if (!hDidChange && fabs(NSMaxX(frame) - NSMaxX(myFrame)) <= gravity) {
                    //NSLog(@"NSMaxX(frame) - NSMaxX(myFrame)");
                    myFrame.origin.x += NSMaxX(frame) - NSMaxX(myFrame);
                    hDidChange = YES;
                }
                
                // vertical magnet /
                if (!vDidChange && fabs(NSMinY(frame) - NSMinY(myFrame)) <= gravity) {
                    //NSLog(@"NSMinY(frame) - NSMinY(myFrame)");
                    myFrame.origin.y = frame.origin.y;
                    vDidChange = YES;
                } if (!vDidChange && fabs(NSMinY(frame) - NSMaxY(myFrame)) <= gravity) {
                    //NSLog(@"NSMinY(frame) - NSMaxY(myFrame)");
                    myFrame.origin.y += NSMinY(frame) - NSMaxY(myFrame);
                    vDidChange = YES;
                } if (!vDidChange && fabs(NSMaxY(frame) - NSMinY(myFrame)) <= gravity) {
                    //NSLog(@"NSMaxY(frame) - NSMinY(myFrame)");
                    myFrame.origin.y = NSMaxY(frame);
                    vDidChange = YES;
                } if (!vDidChange && fabs(NSMaxY(frame) - NSMaxY(myFrame)) <= gravity) {
                    //NSLog(@"(NSMaxY(frame) - NSMaxY(myFrame)");
                    myFrame.origin.y += NSMaxY(frame) - NSMaxY(myFrame);
                    vDidChange = YES;
                }
            }
            [theWindow setFrame:myFrame display:YES];
        }
    }
}

@end
