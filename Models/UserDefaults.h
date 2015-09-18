//
//  Created by Hasan Sa on 9/18/15.
//  Copyright © 2015 HWS. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IDPoi.h"

@interface UserDefaults : NSObject

+ (UserDefaults *)sharedDefaults;
- (BOOL)profileMode;
- (NSString*)userID;
- (NSString*)projectID;
- (BOOL)developerUser;
- (NSInteger)mapType;
- (NSInteger)mapRotation;
- (BOOL)userLayer;
- (BOOL)campusLayer;
- (BOOL)facilityLayer;
- (BOOL)poisLayer;
- (BOOL)pathsLayer;
- (BOOL)routeLayer;
- (BOOL)labelsLayer;
- (NSArray *)visibleCategories;
- (BOOL)muteMode;
- (BOOL)simulationMode;
- (BOOL)simulatedLocationMode;
- (NSString *)language;
- (NSDictionary *)userPersonalPois;
- (NSDictionary *)userPersonalRecentSearch;
- (NSArray*)myTripPois;
- (IDPoi*)myTripNavigationPio;
- (NSArray*)myTripArrivedPois;
- (BOOL)myTripListContainsPoi:(IDPoi*)aPoi;
- (BOOL)myTripListContainsPoi:(IDPoi*)aPoi withArray:(NSArray*)arr;
- (BOOL)multiApikeysMode;
//
- (BOOL)analyticsMode;
- (BOOL)locationSharingMode;
- (BOOL)userlocationsMode;
//
- (NSString*)kAppApiKey;
//
- (void)setAppApiKey:(NSString*)anApiKey;
- (void)setMultiApikeysMode:(BOOL)aMode;

- (void)setLocationSharingMode:(BOOL)aMode;
- (void)setAnalyticsMode:(BOOL)mode;
- (void)setUserLocationsMode:(BOOL)mode;

- (void)updateMyTripPoisWithdArray:(NSArray*)sortedArr;
- (void)updateMyTripPoiWithPoi:(IDPoi*)aPoi add:(BOOL)add;
- (void)updateMyTripArrivedPoisWithPoi:(IDPoi*)aPoi add:(BOOL)add;
- (void)setMyTripNavigationPoi:(IDPoi*)aPoi;
- (void)setProfileMode:(BOOL)mode;
- (void)setUserID:(NSString*)userID;
- (void)setProjectID:(NSString*)projectID;
- (void)setDeveloperUser:(BOOL)mode;
- (void)setMapType:(NSInteger)type;
- (void)setMapRotation:(NSInteger)type;
- (void)setUserLayer:(BOOL)mode;
- (void)setCampusLayer:(BOOL)mode;
- (void)setFacilityLayer:(BOOL)mode;
- (void)setPoisLayer:(BOOL)mode;
- (void)setPathsLayer:(BOOL)mode;
- (void)setRouteLayer:(BOOL)mode;
- (void)setLabelsLayer:(BOOL)mode;
- (void)setVisibleCategories:(NSArray *)categories;
- (void)setSimulationMode:(BOOL)mode;
- (void)setSimulatedLocationMode:(BOOL)mode;
- (void)setMutedMode:(BOOL)mode;
- (void)setUserPersonalLanguage:(NSString *)language;
- (void)setUserPersonalPoi:(NSDictionary *)poiData;
- (void)setUserPersonalRecentSearch:(NSDictionary *)recentSearchData;

@end
