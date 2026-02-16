//
//  Localize.swift
//  Asseerat
//
//  Created by Nargiza Rahimova on 17/11/25.
//

import Foundation
import Foundation

struct Localize {
    // Login
    static var skip: String { "skip".localized }
    static var getStarted: String { "getStarted".localized }
    static var onboard1Title: String { "onboard1Title".localized }
    static var onboard2Title: String { "onboard2Title".localized }
    static var onboard3Title: String { "onboard3Title".localized }
    static var onboard4Title: String { "onboard4Title".localized }
    static var onboard5Title: String { "onboard5Title".localized }
    
    static var onboard1Detail: String { "onboard1Detail".localized }
    static var onboard2Detail: String { "onboard2Detail".localized }
    static var onboard3Detail: String { "onboard3Detail".localized }
    static var onboard4Detail: String { "onboard4Detail".localized }
    static var onboard5Detail: String { "onboard5Detail".localized }
    
    static var passwordValidationString: String { "passwordValidationString".localized }
   
    static var logIn: String { "logIn".localized }
    static var loginDetail: String { "loginDetail".localized }
    static var telephone: String { "telephone".localized }
    static var password: String { "password".localized }
    static var login: String { "login".localized }
    static var forgetPassword: String { "forgetPassword".localized }
    static var loginWith: String { "loginWith".localized }
    static var dontHaveAccount: String { "dontHaveAccount".localized }
    static var signUp: String { "signUp".localized }
    
    
    // SIGN UP
    static var joinUs: String { "joinUs".localized } //Joining us
    static var joinUsDetail: String { "joinUsDetail".localized } //"This information helps us provide you with more relevant and engaging content"
    static var name: String { "name".localized } //Name
    static var lastName: String { "lastName".localized } //Last name
    static var date: String { "date".localized } //Date
    static var register: String { "register".localized } //Register
    static var registerTerm: String { "registerTerm".localized } //"By registering, you accept the terms of the"
    static var privacyPolicy: String { "privacyPolicy".localized } //"Privacy Policy"
    static var areURegistered: String { "areURegistered".localized } //"Are you registered?"
    static var male: String { "male".localized } //"Male"
    static var female: String { "female".localized } //"Female"
   
    static var changePassword: String { "changePassword".localized } //"Change password"
    static var enterPassDetail: String { "enterPassDetail".localized } //"Please enter your phone number to receive a verification code"
    static var verify: String { "verify".localized } //"Verify"
    static var enterOTPCode: String { "enterOTPCode".localized } //"Enter OTP code"
    static var enterOTPCodeDetail: String { "enterOTPCodeDetail".localized } // "We’ve sent an SMS with an activation code to your phone \(phone) number to receive a verification code"
    static var confirm: String { "confirm".localized } //"Confirm"
    static var sentNew: String { "sentNew".localized } //"Sent New"
    static var confirmPassword: String { "confirmPassword".localized } //"Confirm password"
    static var createPassword: String { "createPassword".localized } //"Create password"
    static var resetPassword: String { "resetPassword".localized } //"Reset password"
    static var resetPasswordDetail: String { "resetPasswordDetail".localized } //"Please type something you’ll remember"
    static var setPassword: String { "setPassword".localized } //"Set password"
    static var setPasswordDetail: String { "setPasswordDetail".localized } //"You are registering with +\(String(phone.dropFirst(3)).reformatAsPhone9()) phone number. Set specific password for it."
    
    
    
    // HOME
    static var home: String { "home".localized } //"Home"
    static var sunnahs: String { "sunnahs".localized } //"Sunnahs"
    static var dhikrs: String { "dhikrs".localized } //"Dhikr"
   
    static var home11Title: String { "home11Title".localized } //"Life of the\nProphet"
    static var home11Subtitle: String { "home11Subtitle".localized } //"A Timeless Journey of Light,\nMercy, and Revelation"
    static var home21Title: String { "home21Title".localized } //"Shama’il"
    static var home21Subtitle: String { "home21Subtitle".localized } //"Exploring the Beauty and Character of the Prophet"
    static var home22Title: String { "home22Title".localized } //"AR Experience"
    static var home22Subtitle: String { "home22Subtitle".localized } //"Bring Sacred Artifacts to Your Space
    static var home23Title: String { "home23Title".localized } //"Maps & Key Locations"
    static var home23Subtitle: String { "home23Subtitle".localized } //"Relive the Prophet’s Campaigns"
    static var home31Title: String { "home31Title".localized } //"Companins of\nthe Prophet"
    static var home31Subtitle: String { "home31Subtitle".localized } //"Stories of Courage,\nLove, and Faith"
    static var home41Title: String { "home41Title".localized } //"Family of the\nProphet"
    static var home41Subtitle: String { "home41Subtitle".localized } //"Stories of Love,\nStrength, and Faith\nfrom His Family"
    static var home51Title: String { "home51Title".localized } //"Sunnah in\nDaily Life"
    static var home51Subtitle: String { "home51Subtitle".localized } //"Practical applications\nof the Sunnah in modern\ndaily life"
    static var allowLocationAccess: String { "allowLocationAccess".localized } //"Allow location\naccess"
    static var dailySunnahAnalytics: String { "dailySunnahAnalytics".localized } //"Daily sunnah analytics"
    
    
    
    
    // HOME DETAIL
    static var lifeListNavTitle: String { "lifeListNavTitle".localized } //"Life of the Prophet"
    static var shamailListNavTitle: String { "shamailListNavTitle".localized } //"Shama’il"
    static var companionListNavTitle: String { "companionListNavTitle".localized } //"Companions of the Prophet"
    static var familyListNavTitle: String { "familyListNavTitle".localized } //"Family of the Prophet"
    static var sunnahListNavTitle: String { "sunnahListNavTitle".localized } //"Sunnah in Daily Life"
    
    static var lifeList1Title: String { "lifeList1Title".localized } //"Before Prophethood"
    static var lifeList1Subtitle: String { "lifeList1Subtitle".localized } //"A life of truthfulness, trust, and reflection"
    static var lifeList2Title: String { "lifeList2Title".localized } //"Meccan Period"
    static var lifeList2Subtitle: String { "lifeList2Subtitle".localized } //"Calling to monotheism with patience and perseverance"
    static var lifeList3Title: String { "lifeList3Title".localized } //"Medinan Period"
    static var lifeList3Subtitle: String { "lifeList3Subtitle".localized } //"Establishing a just and compassionate community"
    static var lifeList4Title: String { "lifeList4Title".localized } //"After the Prophet"
    static var lifeList4Subtitle: String { "lifeList4Subtitle".localized } //"His legacy lives on in hearts and guidance"
    
    static var shamailList1Title: String { "shamailList1Title".localized } //"Physical Description"
    static var shamailList1Subtitle: String { "shamailList1Subtitle".localized } //"Noble presence and radiant dignity"
    static var shamailList2Title: String { "shamailList2Title".localized } //"Appearance"
    static var shamailList2Subtitle: String { "shamailList2Subtitle".localized } //"Simplicity with graceful cleanliness"
    static var shamailList3Title: String { "shamailList3Title".localized } //"Eating Habits"
    static var shamailList3Subtitle: String { "shamailList3Subtitle".localized } //"Moderation with gratitude"
    static var shamailList4Title: String { "shamailList4Title".localized } //"Manners"
    static var shamailList4Subtitle: String { "shamailList4Subtitle".localized } //"Gentleness in speech and conduct"
    static var shamailList5Title: String { "shamailList5Title".localized } //"Daily Life"
    static var shamailList5Subtitle: String { "shamailList5Subtitle".localized } //"A life of devotion and balance"
    static var shamailList6Title: String { "shamailList6Title".localized } //"Compassion"
    static var shamailList6Subtitle: String { "shamailList6Subtitle".localized } //"Boundless mercy to all creation"
    
    static var companionList1Title: String { "companionList1Title".localized } //"The Ten Promised Paradise"
    static var companionList1Subtitle: String { "companionList1Subtitle".localized } //"Pioneers of faith, promised eternal reward"
    static var companionList2Title: String { "companionList2Title".localized } //"The Four Rightly Guided"
    static var companionList2Subtitle: String { "companionList2Subtitle".localized } //"Leaders of wisdom, justice, and prophetic legacy"
    static var companionList3Title: String { "companionList3Title".localized } //"Scholars among Sahaba"
    static var companionList3Subtitle: String { "companionList3Subtitle".localized } //"Guardians of knowledge and transmitters of truth"
    static var companionList4Title: String { "companionList4Title".localized } //"Caliphs"
    static var companionList4Subtitle: String { "companionList4Subtitle".localized } //"Stewards of the Ummah and defenders of Islam"
    static var companionList5Title: String { "companionList5Title".localized } //"Female"
    static var companionList5Subtitle: String { "companionList5Subtitle".localized } //"Women of strength, piety, and unwavering devotion"
    static var companionList6Title: String { "companionList6Title".localized } //"Young"
    static var companionList6Subtitle: String { "companionList6Subtitle".localized } //"Youthful hearts empowered by faith."
    static var companionList7Title: String { "companionList7Title".localized } //"Heroes"
    static var companionList7Subtitle: String { "companionList7Subtitle".localized } //"Brave souls who stood firm in truth and sacrifice"
    
    static var familyList1Title: String { "familyList1Title".localized } //"Wives"
    static var familyList1Subtitle: String { "familyList1Subtitle".localized } //"Mothers of the Believers, pillars of support and wisdom"
    static var familyList2Title: String { "familyList2Title".localized } //"Sons"
    static var familyList2Subtitle: String { "familyList2Subtitle".localized } //"Brief lights of love and loss in the Prophet’s life"
    static var familyList3Title: String { "familyList3Title".localized } //"Daughters"
    static var familyList3Subtitle: String { "familyList3Subtitle".localized } //"Models of strength and deep devotion"
    static var familyList4Title: String { "familyList4Title".localized } //"Ahlul Bayt"
    static var familyList4Subtitle: String { "familyList4Subtitle".localized } //"The noble family, honored in heart and revelation"
    
    static var sunnahList1Title: String { "sunnahList1Title".localized } //"Sunnah of Speech & Manners"
    static var sunnahList1Subtitle: String { "sunnahList1Subtitle".localized } //"Graceful words and noble conduct in every interaction"
    static var sunnahList2Title: String { "sunnahList2Title".localized } //"Sunnah of Eating & Drinking"
    static var sunnahList2Subtitle: String { "sunnahList2Subtitle".localized } //"Gratitude, moderation, and mindful habits"
    static var sunnahList3Title: String { "sunnahList3Title".localized } //"Morning Sunnah"
    static var sunnahList3Subtitle: String { "sunnahList3Subtitle".localized } //"Beginning the day with light, remembrance, and purpose"
    static var sunnahList4Title: String { "sunnahList4Title".localized } //"Sunnah of Sleep"
    static var sunnahList4Subtitle: String { "sunnahList4Subtitle".localized } //"Rest with remembrance and trust in the Divine"
    static var sunnahList5Title: String { "sunnahList5Title".localized } //"Sunnah of Travel"
    static var sunnahList5Subtitle: String { "sunnahList5Subtitle".localized } //"Mindful journeys guided by prayer and etiquette"
    static var sunnahList6Title: String { "sunnahList6Title".localized } //"Weekly Sunnah"
    static var sunnahList6Subtitle: String { "sunnahList6Subtitle".localized } //"Rhythms of worship that renew the spirit"
    static var sunnahList7Title: String { "sunnahList7Title".localized } //"Sunnah in the Masjid"
    static var sunnahList7Subtitle: String { "sunnahList7Subtitle".localized } //"Devotion in the house of Allah."
    static var sunnahList8Title: String { "sunnahList8Title".localized } //"Sunnah of Cleanliness"
    static var sunnahList8Subtitle: String { "sunnahList8Subtitle".localized } //"Purity of body and soul as a path to faith"
    static var sunnahList9Title: String { "sunnahList9Title".localized } //"Sunnah of Dressing"
    static var sunnahList9Subtitle: String { "sunnahList9Subtitle".localized } //"Modesty, cleanliness, and beauty in balance"

    
    // AR EXPERIENCE
    static var arEmtpyTitle: String { "arEmtpyTitle".localized } //"AR Experience Soon!"
    static var arEmtpySubtitle: String { "arEmtpySubtitle".localized } //"We are actively building this feature. Stay tuned for updates."
    static var arNavTitle: String { "arNavTitle".localized } //"AR Experience"
    static var arList: String { "arList".localized } //"AR List"
    static var unknown: String { "unknown".localized } //"Unknown"
    
    
    // MAPS AND KEY LOCATIONS
    static var mapAndKeyLocEmityTitle: String { "mapAndKeyLocEmityTitle".localized } //"Maps & Key Locations Soon!"
    static var mapAndKeyLocEmitySubtitle: String { "mapAndKeyLocEmitySubtitle".localized } //"We are actively building this feature. Stay tuned for updates."
    static var mapAndKeyLocNavTitle: String { "mapAndKeyLocNavTitle".localized } //"Maps & Key Locations"
    static var mapAndKeyLocList: String { "mapAndKeyLocList".localized } //"Maps & Key Locations List"
    
    
    //AI ASISTANT
    static var whatCanIDo: String { "whatCanIDo".localized } //"What Can I Do for\nYou Today?"
    static var aiAssistant: String { "aiAssistant".localized } //"AI Assistant"
    static var sendMessage: String { "sendMessage".localized } //"Send message"
    static var thinking: String { "thinking".localized } //"Thinking..."
    static var aiTypes: String { "aiTypes".localized } // "AI types"
    static var noChatHistoryTitle: String { "noChatHistoryTitle".localized } // "No chat history"
    static var noChatHistorySubtitle: String { "noChatHistorySubtitle".localized } // "Send your first message, and your history will be saved and appear here."
    static var deleteChatActionTittle: String { "deleteChatActionTittle".localized } // "Delete chat."
    static var deleteChatActionSubtittle: String { "deleteChatActionSubtittle".localized } // "Do you really want to delete this chat?"
    static var chatHistory: String { "chatHistory".localized } // "Chat history"
    
    
    // SUNNAH
    static var goal: String { "goal".localized } //"Goal"
    static var type: String { "type".localized } //"Type"
    static var freezed: String { "freezed".localized } //"Freezed"
    static var createSunnahEmpityTitle: String { "createSunnahEmpityTitle".localized } //"Create a sunnah daily"
    static var createSunnahEmpitySubtitle: String { "createSunnahEmpitySubtitle".localized } //"Easily create new Sunnah entries for daily learning."
    static var registerRequiredTitle: String { "registerRequiredTitle".localized } //"Registration Required"
    static var registerRequiredSubtitle: String { "registerRequiredSubtitle".localized } //"In order to use this feature, you must be registered."
    static var daily: String { "daily".localized } //"Daily"
    static var weeklyGoals: String { "weeklyGoals".localized } //"Weekly goals"
    static var monthlyGoals: String { "monthlyGoals".localized } //"Monthly goals"
    static var all: String { "all".localized } //"All"
    
    static var delete: String { "delete".localized } //"Delete"
    static var deleteHabit: String { "deleteHabit".localized } //"Delete habit."
    static var deleteHabitDetail: String { "deleteHabitDetail".localized } //"Do you really want to delete this habit?"
    static var back: String { "back".localized } //"Back"
    static var complete: String { "complete".localized } //"Complete"
    static var unfreeze: String { "unfreeze".localized } //"Unfreeze"
    static var freeze: String { "freeze".localized } //"Freeze"
  
    static var editSunnah: String { "editSunnah".localized } // "Edit Sunnah"
    static var editSunnahs: String { "editSunnahs".localized } // "Edit Sunnahs"
    static var noSunnahEmptyTitle: String { "noSunnahEmptyTitle".localized } //"No sunnahs."
    static var noSunnahEmptySubtitle: String { "noSunnahEmptySubtitle".localized } //"There are no any sunnahs to edit. As soon as adding a new one, it will appear here."
    static var archiveSunnahActionTitle: String { "archiveSunnahActionTitle".localized } // "Archive sunnah."
    static var archiveSunnahActionSubtitle: String { "archiveSunnahActionSubtitle".localized } // "Do you really want to archive this sunnah?"
    static var archive: String { "archive".localized } // "Archive"
    static var successefullyArchived: String { "successefullyArchived".localized } // "Successefully archived."
    static var deleteSunnahActionTitle: String { "deleteSunnahActionTitle".localized } // "Delete sunnah."
    static var deleteSunnahActionSubtitle: String { "deleteSunnahActionSubtitle".localized } //  "Do you really want to delete this sunnah?"
    static var successefullyDeleted: String { "successefullyDeleted".localized } // "Successefully deleted."
    static var done: String { "done".localized } // "Done"
   
    static var addNewSunnah: String { "addNewSunnah".localized } // "Add new habit"
    static var standart: String { "standart".localized } // "Standart"
    static var createCustomSunnah: String { "createCustomSunnah".localized } // "Create custom habit"
    static var addSunnah: String { "addSunnah".localized } // "Add Sunnah"
    static var egMorningMeditator: String { "egMorningMeditator".localized } // "e.g. Morning Meditation"
    static var description: String { "description".localized } // "Description"
    static var list: String { "list".localized } // "List"
    static var howOften: String { "howOften".localized } // "How often?"
    static var remindMe: String { "remindMe".localized } // "Remind me"
    static var myDailyCount: String { "myDailyCount".localized } // "My daily count"
    static var successefullyEdited: String { "successefullyEdited".localized } // "Successefully edited."
    static var successefullyAdded: String { "successefullyAdded".localized } // "Successefully added."
    static var chooseIcon: String { "chooseIcon".localized } // "Choose icon"
    static var period: String { "period".localized } // "Period"
    static var repeats: String { "repeat".localized } // "Repeat"
    static var saveGoals: String { "saveGoals".localized } // "Save goals"
    static var selectTime: String { "selectTime".localized } // "Select Time"
    static var saveTime: String { "saveTime".localized } // "Save Time"
    static var setYourDailyReminder: String { "setYourDailyReminder".localized } // "Set your daily reminder"
   
    static var drinkWater: String { "drinkWater".localized } // "Drink Water"
    static var takeWalk: String { "takeWalk".localized } // "Take a walk"
    static var goToGYM: String { "goToGYM".localized } // "Go to the gym"
    static var loseWeight: String { "loseWeight".localized } //  "Lose weight"
    static var planMyDay: String { "planMyDay".localized } //  "Plan my day"
    static var read: String { "read".localized } // "Read"
    static var medidate: String { "medidate".localized } // "Medidate"
    static var everyDay: String { "everyDay".localized } // "Every day"
    static var everyWeek: String { "everyWeek".localized } // "Every week"
    static var everyMonth: String { "everyDay".localized } // "Every month"
    static var selectWeekDays: String { "selectWeekDays".localized } // "Select weakdays"
    
    static var analytics: String { "analytics".localized } // "Analytics"
    static var overview: String { "overview".localized } //  "Overview"
    static var archived: String { "archived".localized } // "Archived"
    
    static var completedInTotal: String { "completedInTotal".localized } // "Completed in total"
    static var longestStreakEver: String { "longestStreakEver".localized } //  "Longest streak ever"
    static var currentLongestStreak: String { "currentLongestStreak".localized } // "Current longest streak"
    static var required: String { "required".localized } // "Required"
    static var completed: String { "completed".localized } // "Completed"
    static var unarchive: String { "unarchive".localized } // "Unarchive"
    
    static var unarchiveSunnahActionTitle: String { "unarchiveSunnahActionTitle".localized } // "Unarchive sunnah."
    static var unarchiveSunnahActionSubtitle: String { "unarchiveSunnahActionSubtitle".localized } //  "Do you really want to unarchive this sunnah?"
    static var successefullyUnarchived: String { "successefullyUnarchived".localized } // "Successefully unarchived."
    static var noUnarchivedEmptyTittle: String { "noUnarchivedEmptyTittle".localized } // "No archived sunnahs."
    static var noUnarchivedEmptySubtittle: String { "noUnarchivedEmptySubtittle".localized } // "There are no any archived sunnahs. As soon as you archive a sunnah, it will be moved to this section."
    
    
    // DHIKRS
    static var dhikr: String { "dhikr".localized }// "Dhikr"
    static var today: String { "today".localized }// "Today"
    static var allTheTime: String { "allTheTime".localized }// "All the time"
    static var dhikrRating: String { "dhikrRating".localized }// "Dhikr rating"
    static var rounds: String { "rounds".localized }// "Rounds"
    static var count: String { "count".localized }// "Count"
    static var counterList: String { "counterList".localized }// "Counter list"
    static var item: String { "item".localized }// "Item"
    static var areYouSureToDelete: String { "areYouSureToDelete".localized }// "Are you shure, you want to delete"
    static var thisItem: String { "thisItem".localized }// "this item"
    static var no: String { "no".localized }// "No"
    static var youMustHaveOneDhikr: String { "youMustHaveOneDhikr".localized }// "You must have at least one dhikr."
    static var dhikrRequirment: String { "dhikrRequirment".localized }// "Please make sure there are no mistakes in the text when adding new dhikr. It's important — and beneficial for yourself!"
    static var add: String { "add".localized }// "Add"
    static var weekly: String { "weekly".localized }// "Weekly"
    static var allTime: String { "allTime".localized }// "All time"
    static var emailOrPhoneNumber: String { "emailOrPhoneNumber".localized }// "Email or Phone number"
    static var addFriends: String { "addFriends".localized }// "Add friends"
   
    
    // OTHERS
    static var yourLocation: String { "yourLocation".localized }// "Your location"
    static var detactAutomatically: String { "detactAutomatically".localized }// "Detact automatically"
    static var location: String { "location".localized }// "Location"
    static var prayerTimes: String { "prayerTimes".localized }// "Prayer times"
    static var notification: String { "notification".localized }// "Notification"
    static var theme: String { "theme".localized }// "Theme"
    static var security: String { "security".localized }// "Security"
    static var help: String { "help".localized }// "Help"
    static var logOut: String { "logOut".localized }// "Log Out"
    static var logOutDetail: String { "logOutDetail".localized }// "Here’s some alert text. It can span multiple lines if needed!"
    static var yes: String { "yes".localized }// "Yes"
    static var profile: String { "profile".localized }// "Profile"
    static var myDevices: String { "myDevices".localized }// "My devices"
    static var yourDevices: String { "yourDevices".localized }// "Your device"
    static var eMail: String { "eMail".localized }// "E-mail"
    static var dateOfBirth: String { "dateOfBirth".localized }// "Date of birth"
    static var save: String { "save".localized }// "Save"
    static var userInfoSucUpdated: String { "userInfoSucUpdated".localized }// "User info successfully updated!"
    static var deleteAnAccount: String { "deleteAnAccount".localized }// "Delete an account"
    static var deleteAnAccountDetail: String { "deleteAnAccountDetail".localized }// "Here’s some alert text. It can span multiple lines if needed!"
    static var profileEditing: String { "profileEditing".localized }// "Profile Editing"
    static var green: String { "green".localized }// "Green"
    static var gray: String { "gray".localized }// "Gray"
    static var create: String { "create".localized }// "Create"
    static var lang: String { "lang".localized }
    
    static var cancel: String { "cancel".localized }
    static var galery: String { "galery".localized }
    static var camera: String { "camera".localized }
    static var uploadImage: String { "uploadImage".localized }
    static var settings: String { "settings".localized }
    static var cameraRequired: String { "cameraRequired".localized }
    
    static var tellAbout: String { "tellAbout".localized }
    static var letChatAbout: String { "letChatAbout".localized }    
}
