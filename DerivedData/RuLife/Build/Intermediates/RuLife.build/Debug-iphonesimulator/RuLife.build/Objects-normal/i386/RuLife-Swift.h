// Generated by Apple Swift version 2.1 (swiftlang-700.1.101.6 clang-700.1.76)
#pragma clang diagnostic push

#if defined(__has_include) && __has_include(<swift/objc-prologue.h>)
# include <swift/objc-prologue.h>
#endif

#pragma clang diagnostic ignored "-Wauto-import"
#include <objc/NSObject.h>
#include <stdint.h>
#include <stddef.h>
#include <stdbool.h>

#if defined(__has_include) && __has_include(<uchar.h>)
# include <uchar.h>
#elif !defined(__cplusplus) || __cplusplus < 201103L
typedef uint_least16_t char16_t;
typedef uint_least32_t char32_t;
#endif

typedef struct _NSZone NSZone;

#if !defined(SWIFT_PASTE)
# define SWIFT_PASTE_HELPER(x, y) x##y
# define SWIFT_PASTE(x, y) SWIFT_PASTE_HELPER(x, y)
#endif
#if !defined(SWIFT_METATYPE)
# define SWIFT_METATYPE(X) Class
#endif

#if defined(__has_attribute) && __has_attribute(objc_runtime_name)
# define SWIFT_RUNTIME_NAME(X) __attribute__((objc_runtime_name(X)))
#else
# define SWIFT_RUNTIME_NAME(X)
#endif
#if defined(__has_attribute) && __has_attribute(swift_name)
# define SWIFT_COMPILE_NAME(X) __attribute__((swift_name(X)))
#else
# define SWIFT_COMPILE_NAME(X)
#endif
#if !defined(SWIFT_CLASS_EXTRA)
# define SWIFT_CLASS_EXTRA
#endif
#if !defined(SWIFT_PROTOCOL_EXTRA)
# define SWIFT_PROTOCOL_EXTRA
#endif
#if !defined(SWIFT_ENUM_EXTRA)
# define SWIFT_ENUM_EXTRA
#endif
#if !defined(SWIFT_CLASS)
# if defined(__has_attribute) && __has_attribute(objc_subclassing_restricted) 
#  define SWIFT_CLASS(SWIFT_NAME) SWIFT_RUNTIME_NAME(SWIFT_NAME) __attribute__((objc_subclassing_restricted)) SWIFT_CLASS_EXTRA
#  define SWIFT_CLASS_NAMED(SWIFT_NAME) __attribute__((objc_subclassing_restricted)) SWIFT_COMPILE_NAME(SWIFT_NAME) SWIFT_CLASS_EXTRA
# else
#  define SWIFT_CLASS(SWIFT_NAME) SWIFT_RUNTIME_NAME(SWIFT_NAME) SWIFT_CLASS_EXTRA
#  define SWIFT_CLASS_NAMED(SWIFT_NAME) SWIFT_COMPILE_NAME(SWIFT_NAME) SWIFT_CLASS_EXTRA
# endif
#endif

#if !defined(SWIFT_PROTOCOL)
# define SWIFT_PROTOCOL(SWIFT_NAME) SWIFT_RUNTIME_NAME(SWIFT_NAME) SWIFT_PROTOCOL_EXTRA
# define SWIFT_PROTOCOL_NAMED(SWIFT_NAME) SWIFT_COMPILE_NAME(SWIFT_NAME) SWIFT_PROTOCOL_EXTRA
#endif

#if !defined(SWIFT_EXTENSION)
# define SWIFT_EXTENSION(M) SWIFT_PASTE(M##_Swift_, __LINE__)
#endif

#if !defined(OBJC_DESIGNATED_INITIALIZER)
# if defined(__has_attribute) && __has_attribute(objc_designated_initializer)
#  define OBJC_DESIGNATED_INITIALIZER __attribute__((objc_designated_initializer))
# else
#  define OBJC_DESIGNATED_INITIALIZER
# endif
#endif
#if !defined(SWIFT_ENUM)
# define SWIFT_ENUM(_type, _name) enum _name : _type _name; enum SWIFT_ENUM_EXTRA _name : _type
#endif
typedef float swift_float2  __attribute__((__ext_vector_type__(2)));
typedef float swift_float3  __attribute__((__ext_vector_type__(3)));
typedef float swift_float4  __attribute__((__ext_vector_type__(4)));
typedef double swift_double2  __attribute__((__ext_vector_type__(2)));
typedef double swift_double3  __attribute__((__ext_vector_type__(3)));
typedef double swift_double4  __attribute__((__ext_vector_type__(4)));
typedef int swift_int2  __attribute__((__ext_vector_type__(2)));
typedef int swift_int3  __attribute__((__ext_vector_type__(3)));
typedef int swift_int4  __attribute__((__ext_vector_type__(4)));
#if defined(__has_feature) && __has_feature(modules)
@import UIKit;
@import CoreLocation;
#endif

#pragma clang diagnostic ignored "-Wproperty-attribute-mismatch"
#pragma clang diagnostic ignored "-Wduplicate-method-arg"
@class UIWindow;
@class UIApplication;
@class NSObject;

SWIFT_CLASS("_TtC6RuLife11AppDelegate")
@interface AppDelegate : UIResponder <UIApplicationDelegate>
@property (nonatomic, strong) UIWindow * __nullable window;
- (BOOL)application:(UIApplication * __nonnull)application didFinishLaunchingWithOptions:(NSDictionary * __nullable)launchOptions;
- (void)applicationWillResignActive:(UIApplication * __nonnull)application;
- (void)applicationDidEnterBackground:(UIApplication * __nonnull)application;
- (void)applicationWillEnterForeground:(UIApplication * __nonnull)application;
- (void)applicationDidBecomeActive:(UIApplication * __nonnull)application;
- (void)applicationWillTerminate:(UIApplication * __nonnull)application;
- (nonnull instancetype)init OBJC_DESIGNATED_INITIALIZER;
@end

@class UIButton;
@class UITableView;
@class UIBarButtonItem;
@class NSBundle;
@class NSCoder;

SWIFT_CLASS("_TtC6RuLife18HomeViewController")
@interface HomeViewController : UIViewController
@property (nonatomic, weak) IBOutlet UIButton * __null_unspecified buttonBeginRun;
@property (nonatomic, weak) IBOutlet UITableView * __null_unspecified tableView;
@property (nonatomic, weak) IBOutlet UIBarButtonItem * __null_unspecified settingButton;
- (void)viewDidLoad;
- (void)didReceiveMemoryWarning;
- (nonnull instancetype)initWithNibName:(NSString * __nullable)nibNameOrNil bundle:(NSBundle * __nullable)nibBundleOrNil OBJC_DESIGNATED_INITIALIZER;
- (nullable instancetype)initWithCoder:(NSCoder * __nonnull)aDecoder OBJC_DESIGNATED_INITIALIZER;
@end

@class UILabel;

SWIFT_CLASS("_TtC6RuLife25StartWorkoutTableViewCell")
@interface StartWorkoutTableViewCell : UITableViewCell
@property (nonatomic, weak) IBOutlet UILabel * __null_unspecified leftTitleLabel;
@property (nonatomic, weak) IBOutlet UILabel * __null_unspecified leftTextLabel;
@property (nonatomic, weak) IBOutlet UILabel * __null_unspecified rightTitleLabel;
@property (nonatomic, weak) IBOutlet UILabel * __null_unspecified rightTextLabel;
- (void)awakeFromNib;
- (void)setSelected:(BOOL)selected animated:(BOOL)animated;
- (nonnull instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString * __nullable)reuseIdentifier OBJC_DESIGNATED_INITIALIZER;
- (nullable instancetype)initWithCoder:(NSCoder * __nonnull)aDecoder OBJC_DESIGNATED_INITIALIZER;
@end

@class UIImageView;
@class NSMutableArray;
@class CLLocation;
@class CLLocationManager;
@class NSTimer;
@class NSError;

SWIFT_CLASS("_TtC6RuLife26StartWorkoutViewController")
@interface StartWorkoutViewController : UIViewController <CLLocationManagerDelegate>
@property (nonatomic, weak) IBOutlet UIButton * __null_unspecified startButtonLabel;
@property (nonatomic, weak) IBOutlet UIButton * __null_unspecified pauseButtonLabel;
@property (nonatomic, weak) IBOutlet UIButton * __null_unspecified resumeButtonLabel;
@property (nonatomic, weak) IBOutlet UIButton * __null_unspecified finishButtonLabel;
@property (nonatomic, weak) IBOutlet UILabel * __null_unspecified durationLabel;
@property (nonatomic, weak) IBOutlet UILabel * __null_unspecified distanceLabel;
@property (nonatomic, weak) IBOutlet UILabel * __null_unspecified avgSpeedLabel;
@property (nonatomic, weak) IBOutlet UILabel * __null_unspecified caloriesLabel;
@property (nonatomic, weak) IBOutlet UILabel * __null_unspecified maxSpeedLabel;
@property (nonatomic, weak) IBOutlet UILabel * __null_unspecified paceLabel;
@property (nonatomic, weak) IBOutlet UILabel * __null_unspecified avgPaceLabel;
@property (nonatomic, weak) IBOutlet UIButton * __null_unspecified waipointMapButtonLabel;
@property (nonatomic, weak) IBOutlet UIImageView * __null_unspecified gpsStrengthImage;
@property (nonatomic, copy) NSArray<NSMutableArray *> * __nonnull data;
@property (nonatomic, copy) NSArray<CLLocation *> * __nonnull location;
@property (nonatomic) double distance;
@property (nonatomic) BOOL isActiveMaps;
@property (nonatomic) NSInteger gpsStrength;
@property (nonatomic, strong) CLLocationManager * __nonnull locationManager;
- (void)viewDidLoad;
- (void)didReceiveMemoryWarning;
- (IBAction)BackHome:(id __nonnull)sender;
- (IBAction)mapsButton:(UIButton * __nonnull)sender;
- (IBAction)startButton:(UIButton * __nonnull)sender;
- (IBAction)pauseButton:(UIButton * __nonnull)sender;
- (IBAction)resumeButton:(UIButton * __nonnull)sender;
- (IBAction)finishButton:(UIButton * __nonnull)sender;
- (void)updateElapsedTime:(NSTimer * __nonnull)timer;
- (void)locationManager:(CLLocationManager * __nonnull)manager didFailWithError:(NSError * __nonnull)error;
- (void)locationManager:(CLLocationManager * __nonnull)manager didUpdateLocations:(NSArray<CLLocation *> * __nonnull)locations;
- (void)clearLabels;
- (nonnull instancetype)initWithNibName:(NSString * __nullable)nibNameOrNil bundle:(NSBundle * __nullable)nibBundleOrNil OBJC_DESIGNATED_INITIALIZER;
- (nullable instancetype)initWithCoder:(NSCoder * __nonnull)aDecoder OBJC_DESIGNATED_INITIALIZER;
@end


SWIFT_CLASS("_TtC6RuLife20WorkoutTableViewCell")
@interface WorkoutTableViewCell : UITableViewCell
@property (nonatomic, weak) IBOutlet UILabel * __null_unspecified dateLabel;
@property (nonatomic, weak) IBOutlet UIImageView * __null_unspecified imageType;
@property (nonatomic, weak) IBOutlet UILabel * __null_unspecified titleLabel;
@property (nonatomic, weak) IBOutlet UILabel * __null_unspecified decriptionLabel;
@property (nonatomic, weak) IBOutlet UIImageView * __null_unspecified visibleIcon;
@property (nonatomic, weak) IBOutlet UIImageView * __null_unspecified likeIcon;
- (void)awakeFromNib;
- (void)setSelected:(BOOL)selected animated:(BOOL)animated;
- (nonnull instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString * __nullable)reuseIdentifier OBJC_DESIGNATED_INITIALIZER;
- (nullable instancetype)initWithCoder:(NSCoder * __nonnull)aDecoder OBJC_DESIGNATED_INITIALIZER;
@end

@class NSIndexPath;

SWIFT_CLASS("_TtC6RuLife26WorkoutTableViewController")
@interface WorkoutTableViewController : UITableViewController
@property (nonatomic, strong) IBOutlet UITableView * __null_unspecified table;
- (void)viewDidLoad;
- (void)didReceiveMemoryWarning;
- (NSInteger)numberOfSectionsInTableView:(UITableView * __nonnull)tableView;
- (NSInteger)tableView:(UITableView * __nonnull)tableView numberOfRowsInSection:(NSInteger)section;
- (UITableViewCell * __nonnull)tableView:(UITableView * __nonnull)tableView cellForRowAtIndexPath:(NSIndexPath * __nonnull)indexPath;
- (nonnull instancetype)initWithStyle:(UITableViewStyle)style OBJC_DESIGNATED_INITIALIZER;
- (nonnull instancetype)initWithNibName:(NSString * __nullable)nibNameOrNil bundle:(NSBundle * __nullable)nibBundleOrNil OBJC_DESIGNATED_INITIALIZER;
- (nullable instancetype)initWithCoder:(NSCoder * __nonnull)aDecoder OBJC_DESIGNATED_INITIALIZER;
@end

#pragma clang diagnostic pop
