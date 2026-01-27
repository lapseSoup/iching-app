import Foundation

// MARK: - Hexagrams 33-48

extension HexagramLibrary {
    
    func createHexagram33() -> Hexagram {
        Hexagram(
            id: 33,
            chineseName: "遯",
            pinyin: "dùn",
            englishName: "Retreat",
            character: "䷠",
            upperTrigram: .heaven,
            lowerTrigram: .mountain,
            judgment: """
                RETREAT. Success.
                In what is small, perseverance furthers.
                """,
            image: """
                Mountain under heaven: the image of RETREAT.
                Thus the superior man keeps the inferior man at a distance,
                Not angrily but with reserve.
                """,
            commentary: """
                The power of the dark is ascending. The light retreats to security, so that the dark cannot encroach upon it. This retreat is a matter not of man's will but of natural law.
                
                Retreat is not the same as flight. Flight means saving oneself under any circumstances, whereas in retreat one's composure is maintained. Retreat is a sign of strength; it is not defeat but strategic withdrawal to preserve resources for a better time.
                """,
            lineTexts: [
                LineMeaning(position: 1, text: "At the tail in retreat. This is dangerous. One must not wish to undertake anything.", interpretation: "Being at the rear during retreat is dangerous. Do not attempt new ventures; focus only on safe withdrawal."),
                LineMeaning(position: 2, text: "He holds him fast with yellow ox hide. No one can tear him loose.", interpretation: "A strong bond holds one to a worthy cause or person. This connection is unbreakable and right."),
                LineMeaning(position: 3, text: "A halted retreat is nerve-wracking and dangerous. To retain people as men- and maidservants brings good fortune.", interpretation: "Delayed retreat causes anxiety and risk. Keep capable helpers close; their support makes the difficult time manageable."),
                LineMeaning(position: 4, text: "Voluntary retreat brings good fortune to the superior man and downfall to the inferior man.", interpretation: "The noble person chooses to retreat gracefully and benefits. The petty person clings and loses everything."),
                LineMeaning(position: 5, text: "Friendly retreat. Perseverance brings good fortune.", interpretation: "Retreat executed with good grace and on friendly terms. The right timing makes the withdrawal go smoothly."),
                LineMeaning(position: 6, text: "Cheerful retreat. Everything serves to further.", interpretation: "Retreat accomplished with such complete ease and detachment that it becomes almost joyful. Full success in withdrawal.")
            ]
        )
    }
    
    func createHexagram34() -> Hexagram {
        Hexagram(
            id: 34,
            chineseName: "大壯",
            pinyin: "dà zhuàng",
            englishName: "The Power of the Great",
            character: "䷡",
            upperTrigram: .thunder,
            lowerTrigram: .heaven,
            judgment: """
                THE POWER OF THE GREAT. Perseverance furthers.
                """,
            image: """
                Thunder in heaven above:
                The image of THE POWER OF THE GREAT.
                Thus the superior man does not tread upon paths
                That do not accord with established order.
                """,
            commentary: """
                The great lines, that is, the light, strong lines, are powerful. Four light lines have entered the hexagram from below and are about to ascend higher. This indicates great power.
                
                But true greatness depends on being in harmony with what is right. Therefore the judgment adds: "Perseverance furthers." Power exercised without justice becomes mere violence and leads to destruction. Only power that perseveres in the right is truly great.
                """,
            lineTexts: [
                LineMeaning(position: 1, text: "Power in the toes. Continuing brings misfortune. This is certainly true.", interpretation: "Power in the lowest position. Pushing forward forcefully from a weak position leads to misfortune. Restraint is needed."),
                LineMeaning(position: 2, text: "Perseverance brings good fortune.", interpretation: "With growing power comes the temptation to push forward. Steady perseverance rather than aggressive advancement brings good fortune."),
                LineMeaning(position: 3, text: "The inferior man works through power. The superior man does not act thus. To continue is dangerous. A goat butts against a hedge and gets its horns entangled.", interpretation: "Using power aggressively leads to entanglement. The wise avoid such crude demonstrations of force."),
                LineMeaning(position: 4, text: "Perseverance brings good fortune. Remorse disappears. The hedge opens; there is no entanglement. Power depends upon the axle of a big cart.", interpretation: "Obstacles dissolve for one who perseveres with true power—power that is grounded and moving in the right direction."),
                LineMeaning(position: 5, text: "Loses the goat with ease. No remorse.", interpretation: "The stubborn, pushing energy dissolves. Letting go of aggressive tendencies comes easily and brings no regret."),
                LineMeaning(position: 6, text: "A goat butts against a hedge. It cannot go backward, it cannot go forward. Nothing serves to further. If one notes the difficulty, this brings good fortune.", interpretation: "Power has pushed forward too far and is stuck. Recognizing the difficulty allows for change, which ultimately brings good fortune.")
            ]
        )
    }
    
    func createHexagram35() -> Hexagram {
        Hexagram(
            id: 35,
            chineseName: "晉",
            pinyin: "jìn",
            englishName: "Progress",
            character: "䷢",
            upperTrigram: .fire,
            lowerTrigram: .earth,
            judgment: """
                PROGRESS. The powerful prince
                Is honored with horses in large numbers.
                In a single day he is granted audience three times.
                """,
            image: """
                The sun rises over the earth:
                The image of PROGRESS.
                Thus the superior man himself
                Brightens his bright virtue.
                """,
            commentary: """
                The hexagram represents the sun rising over the earth. It is therefore the symbol of rapid, easy progress, which at the same time means ever-widening expansion and clarity.
                
                The ruler is pictured as a powerful prince whose authority raises him above the nobility and leads to exceptional recognition. A person in an expanding position is granted special access and receives extraordinary gifts as rewards for their virtue.
                """,
            lineTexts: [
                LineMeaning(position: 1, text: "Progressing, but turned back. Perseverance brings good fortune. If one meets with no confidence, one should remain calm. No mistake.", interpretation: "Initial attempts at progress are rebuffed. Remain calm and steadfast despite lack of recognition. This brings no blame."),
                LineMeaning(position: 2, text: "Progressing, but in sorrow. Perseverance brings good fortune. Then one obtains great happiness from one's ancestress.", interpretation: "Progress comes despite obstacles. Steadfast effort brings blessing from a source of maternal wisdom and tradition."),
                LineMeaning(position: 3, text: "All are in accord. Remorse disappears.", interpretation: "Progress gains support from all directions. Previous regrets dissolve as the way forward becomes clear and supported."),
                LineMeaning(position: 4, text: "Progress like a hamster. Perseverance brings danger.", interpretation: "Progressing by hoarding and grasping, like a hamster. Such behavior, even if persistent, brings danger. Change approach."),
                LineMeaning(position: 5, text: "Remorse disappears. Take not gain and loss to heart. Undertakings bring good fortune. Everything serves to further.", interpretation: "Regret vanishes when one stops calculating gains and losses. Acting freely from pure motivation, everything furthers progress."),
                LineMeaning(position: 6, text: "Making progress with the horns is permissible only for the purpose of punishing one's own city. To be conscious of danger brings good fortune. No blame. Perseverance brings humiliation.", interpretation: "Aggressive progress is appropriate only for correcting one's own domain. Awareness of the dangers involved brings good fortune; stubborn persistence brings shame.")
            ]
        )
    }
    
    func createHexagram36() -> Hexagram {
        Hexagram(
            id: 36,
            chineseName: "明夷",
            pinyin: "míng yí",
            englishName: "Darkening of the Light",
            character: "䷣",
            upperTrigram: .earth,
            lowerTrigram: .fire,
            judgment: """
                DARKENING OF THE LIGHT. In adversity
                It furthers one to be persevering.
                """,
            image: """
                The light has sunk into the earth:
                The image of DARKENING OF THE LIGHT.
                Thus does the superior man live with the great mass:
                He veils his light, yet still shines.
                """,
            commentary: """
                Here the sun has sunk under the earth and is therefore darkened. The name of the hexagram means literally "wounding of the bright"; hence the individual lines contain frequent references to wounding.
                
                The situation is one in which a person of genuine ability must hide their capabilities because of dark conditions. They must conceal their light, appearing simple and ordinary, while inwardly maintaining clarity. One must not let adversity undermine inner worth.
                """,
            lineTexts: [
                LineMeaning(position: 1, text: "Darkening of the light during flight. He lowers his wings. The superior man does not eat for three days on his wanderings. But he has somewhere to go. The host has occasion to gossip about him.", interpretation: "In retreat, the wise person endures hardship. Though criticized by those who don't understand, one perseveres toward a clear goal."),
                LineMeaning(position: 2, text: "Darkening of the light injures him in the left thigh. He gives aid with the strength of a horse. Good fortune.", interpretation: "Wounded but still able to help others with vigor. Despite personal injury, lending strength to rescue those in need brings good fortune."),
                LineMeaning(position: 3, text: "Darkening of the light during the hunt in the south. Their great leader is captured. One must not expect perseverance too soon.", interpretation: "In pursuing the source of darkness, the main offender is found. But complete reform cannot be expected immediately; patience is needed."),
                LineMeaning(position: 4, text: "He penetrates the left side of the belly. One gets at the very heart of the darkening of the light, and leaves gate and courtyard.", interpretation: "One perceives the inner nature of the darkness and, understanding it fully, chooses to withdraw completely from the corrupt environment."),
                LineMeaning(position: 5, text: "Darkening of the light as with Prince Chi. Perseverance furthers.", interpretation: "Like Prince Chi who feigned madness to survive under a tyrant, concealing one's true nature may be necessary. Inner constancy must be maintained."),
                LineMeaning(position: 6, text: "Not light but darkness. First he climbed up to heaven, then he plunged into the depths of the earth.", interpretation: "The source of darkness has reached its peak and now falls. What rose to the heights through evil means inevitably descends to destruction.")
            ]
        )
    }
    
    func createHexagram37() -> Hexagram {
        Hexagram(
            id: 37,
            chineseName: "家人",
            pinyin: "jiā rén",
            englishName: "The Family (The Clan)",
            character: "䷤",
            upperTrigram: .wind,
            lowerTrigram: .fire,
            judgment: """
                THE FAMILY. The perseverance of the woman furthers.
                """,
            image: """
                Wind comes forth from fire:
                The image of THE FAMILY.
                Thus the superior man has substance in his words
                And duration in his way of life.
                """,
            commentary: """
                The foundation of the family is the relationship between husband and wife. The tie that holds the family together lies in the loyalty and perseverance of the wife. The place of the family in society is represented by the trigrams: fire within, wind outside.
                
                The family is society in embryo; it is the native soil on which performance of moral duty is made easy through natural affection. The laws of the family apply universally. Each person must cultivate the virtues that make a household thrive.
                """,
            lineTexts: [
                LineMeaning(position: 1, text: "Firm seclusion within the family. Remorse disappears.", interpretation: "Clear boundaries and proper order within the family from the start prevent later regrets. Early discipline creates lasting harmony."),
                LineMeaning(position: 2, text: "She should not follow her whims. She must attend within to the food. Perseverance brings good fortune.", interpretation: "Attending to the essential nourishment—both physical and spiritual—of the family brings good fortune. Focus on duties, not personal desires."),
                LineMeaning(position: 3, text: "When tempers flare up in the family, too great severity brings remorse. Good fortune nonetheless. When woman and child dally and laugh, it leads in the end to humiliation.", interpretation: "Strictness may cause regret, but it's better than excessive leniency. Discipline that seems harsh is preferable to disorder."),
                LineMeaning(position: 4, text: "She is the treasure of the house. Great good fortune.", interpretation: "One who maintains the household wisely, creating prosperity through care and management, is the true treasure of the family."),
                LineMeaning(position: 5, text: "As a king he approaches his family. Fear not. Good fortune.", interpretation: "Leadership in the family with love rather than fear. When the head of the household leads with virtue and affection, all goes well."),
                LineMeaning(position: 6, text: "His work commands respect. In the end good fortune comes.", interpretation: "When one's character and work command genuine respect, the family flourishes. Inner truth brings outward recognition.")
            ]
        )
    }
    
    func createHexagram38() -> Hexagram {
        Hexagram(
            id: 38,
            chineseName: "睽",
            pinyin: "kuí",
            englishName: "Opposition",
            character: "䷥",
            upperTrigram: .fire,
            lowerTrigram: .lake,
            judgment: """
                OPPOSITION. In small matters, good fortune.
                """,
            image: """
                Above, fire; below, the lake:
                The image of OPPOSITION.
                Thus amid all fellowship
                The superior man retains his individuality.
                """,
            commentary: """
                This hexagram is composed of the trigram Li above, meaning fire, and the trigram Dui below, meaning the lake. Fire moves upward and water moves downward—they move in opposite directions.
                
                Opposition indicates a time when things that should work together are instead at odds. In such times, one cannot expect large undertakings to succeed. But in small matters, by carefully adapting to circumstances while maintaining one's own nature, progress can be made.
                """,
            lineTexts: [
                LineMeaning(position: 1, text: "Remorse disappears. If you lose your horse, do not run after it; it will come back of its own accord. When you see evil people, guard yourself against mistakes.", interpretation: "Let go of what has departed; it will return naturally. When encountering difficult people, maintain composure and avoid provocation."),
                LineMeaning(position: 2, text: "One meets his lord in a narrow street. No blame.", interpretation: "An informal, chance meeting brings connection despite formal opposition. Unplanned encounters can resolve standoffs."),
                LineMeaning(position: 3, text: "One sees the wagon dragged back, the oxen halted, a man's hair and nose cut off. Not a good beginning, but a good end.", interpretation: "Everything seems to go wrong and one appears humiliated. But these obstacles clear the way for eventual success."),
                LineMeaning(position: 4, text: "Isolated through opposition, one meets a like-minded man with whom one can associate in good faith. Despite the danger, no blame.", interpretation: "Though isolated by general opposition, finding one trustworthy ally allows progress. This genuine connection brings no blame."),
                LineMeaning(position: 5, text: "Remorse disappears. The companion bites his way through the wrappings. If one goes to him, how could it be a mistake?", interpretation: "A loyal friend breaks through barriers to reach you. Going to meet such genuine support is never a mistake."),
                LineMeaning(position: 6, text: "Isolated through opposition. One sees one's companion as a pig covered with dirt, as a wagon full of devils. First one draws a bow against him, then one lays the bow aside. He is not a robber; he will woo at the right time. As one goes, rain falls; then good fortune comes.", interpretation: "Suspicion and mistrust create false impressions. When one sees clearly that the perceived enemy is actually a friend, reconciliation brings good fortune like rain after drought.")
            ]
        )
    }
    
    func createHexagram39() -> Hexagram {
        Hexagram(
            id: 39,
            chineseName: "蹇",
            pinyin: "jiǎn",
            englishName: "Obstruction",
            character: "䷦",
            upperTrigram: .water,
            lowerTrigram: .mountain,
            judgment: """
                OBSTRUCTION. The southwest furthers.
                The northeast does not further.
                It furthers one to see the great man.
                Perseverance brings good fortune.
                """,
            image: """
                Water on the mountain:
                The image of OBSTRUCTION.
                Thus the superior man turns his attention to himself
                And molds his character.
                """,
            commentary: """
                The hexagram pictures a dangerous abyss lying before us and a steep, inaccessible mountain rising behind us. We are surrounded by obstacles. The southwest—the direction of retreat—offers safety; the northeast—the direction of advance—does not.
                
                In such a situation, the wise person pauses to examine themselves and cultivate their character. The only response to external obstruction is internal development. When the way forward is blocked, improve yourself while waiting for conditions to change.
                """,
            lineTexts: [
                LineMeaning(position: 1, text: "Going leads to obstructions; coming meets with praise.", interpretation: "Attempting to advance brings difficulties; returning brings recognition. This is not the time to push forward."),
                LineMeaning(position: 2, text: "The king's servant is beset by obstruction upon obstruction, but it is not his own fault.", interpretation: "One serving a higher cause encounters repeated obstacles. Though difficult, this is no personal failure; duty requires perseverance."),
                LineMeaning(position: 3, text: "Going leads to obstructions; hence he comes back.", interpretation: "Recognizing that advancement is impossible, one wisely returns. Those who depend on you welcome your return."),
                LineMeaning(position: 4, text: "Going leads to obstructions; coming leads to union.", interpretation: "Advancement alone is blocked, but returning brings connection with others. Together, what was impossible alone becomes possible."),
                LineMeaning(position: 5, text: "In the midst of the greatest obstructions, friends come.", interpretation: "At the height of difficulty, help arrives. The obstruction itself draws support from those who recognize the struggle."),
                LineMeaning(position: 6, text: "Going leads to obstructions, coming leads to great good fortune. It furthers one to see the great man.", interpretation: "The obstruction reaches its peak and begins to dissolve. Seeking guidance from those of wisdom and experience brings great good fortune.")
            ]
        )
    }
    
    func createHexagram40() -> Hexagram {
        Hexagram(
            id: 40,
            chineseName: "解",
            pinyin: "xiè",
            englishName: "Deliverance",
            character: "䷧",
            upperTrigram: .thunder,
            lowerTrigram: .water,
            judgment: """
                DELIVERANCE. The southwest furthers.
                If there is no longer anything where one has to go,
                Return brings good fortune.
                If there is still something where one has to go,
                Hastening brings good fortune.
                """,
            image: """
                Thunder and rain set in:
                The image of DELIVERANCE.
                Thus the superior man pardons mistakes
                And forgives misdeeds.
                """,
            commentary: """
                This hexagram points to the clearing of tension, the release of difficulties. The relief comes like a thunderstorm that clears the air and brings release after a period of oppressive tension.
                
                Deliverance requires appropriate action. If problems have been fully resolved, return to normal life immediately—don't linger in the crisis mode. If issues remain, address them quickly and decisively. Either way, act in harmony with the moment of release.
                """,
            lineTexts: [
                LineMeaning(position: 1, text: "Without blame.", interpretation: "The moment of deliverance has arrived. Nothing needs to be done; simply accepting the release brings no blame."),
                LineMeaning(position: 2, text: "One kills three foxes in the field and receives a yellow arrow. Perseverance brings good fortune.", interpretation: "In the process of deliverance, obstacles are removed. Recognition comes for dealing with devious problems. Steadfastness brings good fortune."),
                LineMeaning(position: 3, text: "If a man carries a burden on his back and nonetheless rides in a carriage, he thereby encourages robbers to draw near. Perseverance leads to humiliation.", interpretation: "Acting above one's station invites trouble. Clinging to gains beyond one's proper position, even persistently, leads to humiliation."),
                LineMeaning(position: 4, text: "Deliver yourself from your great toe. Then the companion comes, and him you can trust.", interpretation: "Free yourself from unworthy attachments. Only then can true friends approach. Remove what hinders genuine connection."),
                LineMeaning(position: 5, text: "If only the superior man can deliver himself, it brings good fortune. Thus he proves to inferior men that he is in earnest.", interpretation: "The capable person extricates themselves from difficulty. This self-deliverance demonstrates authentic character to all."),
                LineMeaning(position: 6, text: "The prince shoots at a hawk on a high wall. He kills it. Everything serves to further.", interpretation: "The final obstacle is overcome through skill and decisiveness. Removing the last barrier to deliverance brings complete success.")
            ]
        )
    }
    
    func createHexagram41() -> Hexagram {
        Hexagram(
            id: 41,
            chineseName: "損",
            pinyin: "sǔn",
            englishName: "Decrease",
            character: "䷨",
            upperTrigram: .mountain,
            lowerTrigram: .lake,
            judgment: """
                DECREASE combined with sincerity
                Brings about supreme good fortune
                Without blame.
                One may be persevering in this.
                It furthers one to undertake something.
                How is this to be carried out?
                One may use two small bowls for the sacrifice.
                """,
            image: """
                At the foot of the mountain, the lake:
                The image of DECREASE.
                Thus the superior man controls his anger
                And restrains his instincts.
                """,
            commentary: """
                Decrease does not under all circumstances mean something bad. Increase and decrease come in their own time. What matters is to understand the time and not to cover up poverty with empty pretense.
                
                When the lake at the foot of the mountain evaporates, the mountain is enriched by the moisture. The lower gives to the higher. This brings sacrifice but also opportunity for refinement. When decrease is based on inner truth, the simplest offerings suffice.
                """,
            lineTexts: [
                LineMeaning(position: 1, text: "Going quickly when one's tasks are finished is without blame. But one must reflect on how much one may decrease others.", interpretation: "Completing duties promptly is good. But consider how your efficiency may burden those who must now carry more."),
                LineMeaning(position: 2, text: "Perseverance furthers. To undertake something brings misfortune. Without decreasing oneself, one is able to bring increase to others.", interpretation: "Maintain constancy but avoid new ventures. Help others without depleting yourself; sustainable giving is better than sacrifice."),
                LineMeaning(position: 3, text: "When three people journey together, their number decreases by one. When one man journeys alone, he finds a companion.", interpretation: "Three is an unstable number; one naturally drops off. But one alone naturally finds a companion. Decrease leads to appropriate union."),
                LineMeaning(position: 4, text: "If a man decreases his faults, it makes the other hasten to come and rejoice. No blame.", interpretation: "Reducing one's own faults attracts others quickly and brings joy. Self-improvement draws support without blame."),
                LineMeaning(position: 5, text: "Someone does indeed increase him. Ten pairs of tortoises cannot oppose it. Supreme good fortune.", interpretation: "Unexpected enrichment comes; nothing can prevent this blessing. When fate brings increase, even oracles cannot countermand it."),
                LineMeaning(position: 6, text: "If one is increased without depriving others, there is no blame. Perseverance brings good fortune. It furthers one to undertake something. One obtains servants but no longer has a separate home.", interpretation: "Increase that harms no one is without blame. Such gain leads to greater responsibilities and a larger sphere of influence.")
            ]
        )
    }
    
    func createHexagram42() -> Hexagram {
        Hexagram(
            id: 42,
            chineseName: "益",
            pinyin: "yì",
            englishName: "Increase",
            character: "䷩",
            upperTrigram: .wind,
            lowerTrigram: .thunder,
            judgment: """
                INCREASE. It furthers one
                To undertake something.
                It furthers one to cross the great water.
                """,
            image: """
                Wind and thunder: the image of INCREASE.
                Thus the superior man:
                If he sees good, he imitates it;
                If he has faults, he rids himself of them.
                """,
            commentary: """
                The idea of increase is expressed in the fact that the strong lowest line of the upper trigram has sunk down and taken its place under the lower trigram. This represents sacrifice from above that reaches the people and furthers their development.
                
                This is a time favorable for all kinds of undertakings. The time is propitious; benefit flows downward, creating goodwill and harmony. One should use this time to accomplish something great.
                """,
            lineTexts: [
                LineMeaning(position: 1, text: "It furthers one to accomplish great deeds. Supreme good fortune. No blame.", interpretation: "The time is ideal for significant undertakings. The support from above makes great accomplishment possible without blame."),
                LineMeaning(position: 2, text: "Someone does indeed increase him; ten pairs of tortoises cannot oppose it. Constant perseverance brings good fortune. The king presents him before God. Good fortune.", interpretation: "Destined blessings come that cannot be refused. Persistence brings good fortune, and one's merit is recognized at the highest level."),
                LineMeaning(position: 3, text: "One is enriched through unfortunate events. No blame, if you are sincere and walk in the middle, and report to the prince with a seal.", interpretation: "Benefit comes through difficult circumstances. If one acts sincerely and officially reports the situation, there is no blame."),
                LineMeaning(position: 4, text: "If you walk in the middle and report to the prince, he will follow. It furthers one to be used in the removal of the capital.", interpretation: "One in a mediating position can influence decisions above. This is the time to propose major changes; they will be supported."),
                LineMeaning(position: 5, text: "If in truth you have a kind heart, ask not. Supreme good fortune. Truly, kindness will be recognized as your virtue.", interpretation: "Genuine benevolence needs no proof or questioning. Supreme good fortune comes to one whose kindness is authentic."),
                LineMeaning(position: 6, text: "He brings increase to no one. Indeed, someone even strikes him. He does not keep his heart constantly steady. Misfortune.", interpretation: "One who fails to share increase with others loses it all. Inconstancy of heart brings misfortune; generosity must be genuine and sustained.")
            ]
        )
    }
    
    func createHexagram43() -> Hexagram {
        Hexagram(
            id: 43,
            chineseName: "夬",
            pinyin: "guài",
            englishName: "Break-through (Resoluteness)",
            character: "䷪",
            upperTrigram: .lake,
            lowerTrigram: .heaven,
            judgment: """
                BREAK-THROUGH. One must resolutely make the matter known
                At the court of the king.
                It must be announced truthfully. Danger.
                It is necessary to notify one's own city.
                It does not further to resort to arms.
                It furthers one to undertake something.
                """,
            image: """
                The lake has risen up to heaven:
                The image of BREAK-THROUGH.
                Thus the superior man
                Dispenses riches downward
                And refrains from resting on his virtue.
                """,
            commentary: """
                This hexagram signifies a break-through after a long accumulation of tension, as a swollen river breaks through its dikes. The five strong lines are about to force out the one weak line at the top. Decisive action is indicated.
                
                But the action must be appropriate: open declaration of the truth, warning to allies, and then resolute forward movement. Direct force is not the way; the weak yields to consistent pressure without violence.
                """,
            lineTexts: [
                LineMeaning(position: 1, text: "Mighty in the forward-striding toes. When one goes and is not equal to the task, one makes a mistake.", interpretation: "Rushing forward eagerly without adequate strength leads to failure. Assess your capabilities before acting."),
                LineMeaning(position: 2, text: "A cry of alarm. Arms at evening and at night. Fear nothing.", interpretation: "Vigilance at all hours. Though danger threatens, maintaining alertness removes fear. Preparedness dispels anxiety."),
                LineMeaning(position: 3, text: "To be powerful in the cheekbones brings misfortune. The superior man is firmly resolved. He walks alone and is caught in the rain. He is bespattered, and people murmur against him. No blame.", interpretation: "Aggressive expression brings misfortune. The resolute person proceeds alone despite criticism and discomfort; ultimately there is no blame."),
                LineMeaning(position: 4, text: "There is no skin on his thighs, and walking comes hard. If a man were to let himself be led like a sheep, remorse would disappear. But if these words are heard, they will not be believed.", interpretation: "Progress is painful and difficult. Following guidance would help, but such advice is not heeded. A warning likely to be ignored."),
                LineMeaning(position: 5, text: "In dealing with weeds, firm resolution is necessary. Walking in the middle remains free of blame.", interpretation: "Persistent problems require determined action. Maintaining the middle way while being resolute brings no blame."),
                LineMeaning(position: 6, text: "No cry. In the end misfortune comes.", interpretation: "Failing to sound the alarm or take action when needed leads to misfortune. Silence when speech is called for is a failure.")
            ]
        )
    }
    
    func createHexagram44() -> Hexagram {
        Hexagram(
            id: 44,
            chineseName: "姤",
            pinyin: "gòu",
            englishName: "Coming to Meet",
            character: "䷫",
            upperTrigram: .heaven,
            lowerTrigram: .wind,
            judgment: """
                COMING TO MEET. The maiden is powerful.
                One should not marry such a maiden.
                """,
            image: """
                Under heaven, wind:
                The image of COMING TO MEET.
                Thus does the prince act when disseminating his commands
                And proclaiming them to the four quarters of heaven.
                """,
            commentary: """
                This hexagram indicates a situation where the dark principle, represented by a yielding line, has risen unexpectedly from below and is just about to push upward. The situation must be understood in its incipient stage.
                
                A strong reaction against something dark and corrupting is necessary. The dark force appears harmless at first but can grow quickly in power if not checked. Recognition and immediate action are required.
                """,
            lineTexts: [
                LineMeaning(position: 1, text: "It must be checked with a brake of bronze. Perseverance brings good fortune. If one lets it take its course, one experiences misfortune. Even a lean pig has it in him to rage around.", interpretation: "The corrupting influence must be firmly restrained from the start. What seems weak can become dangerously powerful if not checked."),
                LineMeaning(position: 2, text: "There is a fish in the tank. No blame. Does not further guests.", interpretation: "The dark element is contained and controlled. Keep it under wraps; do not let it spread to others."),
                LineMeaning(position: 3, text: "There is no skin on his thighs, and walking comes hard. If one is mindful of the danger, no great mistake is made.", interpretation: "Movement is difficult and painful. Awareness of the difficulty prevents major errors. Proceed with caution."),
                LineMeaning(position: 4, text: "No fish in the tank. This leads to misfortune.", interpretation: "The people have been alienated; connection has been lost. Without this bond, misfortune follows."),
                LineMeaning(position: 5, text: "A melon covered with willow leaves. Hidden lines. Then it drops down to one from heaven.", interpretation: "Inner worth concealed under modest appearance. Patiently maintaining integrity brings unexpected blessing from above."),
                LineMeaning(position: 6, text: "He comes to meet with his horns. Humiliation. No blame.", interpretation: "Meeting others with aggressive resistance brings humiliation. Though understandable, such defensiveness is regrettable.")
            ]
        )
    }
    
    func createHexagram45() -> Hexagram {
        Hexagram(
            id: 45,
            chineseName: "萃",
            pinyin: "cuì",
            englishName: "Gathering Together (Massing)",
            character: "䷬",
            upperTrigram: .lake,
            lowerTrigram: .earth,
            judgment: """
                GATHERING TOGETHER. Success.
                The king approaches his temple.
                It furthers one to see the great man.
                This brings success. Perseverance furthers.
                To bring great offerings creates good fortune.
                It furthers one to undertake something.
                """,
            image: """
                Over the earth, the lake:
                The image of GATHERING TOGETHER.
                Thus the superior man renews his weapons
                In order to meet the unforeseen.
                """,
            commentary: """
                This hexagram depicts a gathering of people around a leader. The lake above the earth suggests a congregation, like water gathering in a lake. Such a gathering requires a center—a leader or purpose—around which people can unite.
                
                The time is favorable for coming together, but preparation is needed. Gatherings can be dangerous if not properly organized. Great offerings suggest the spirit of sacrifice necessary for successful collective action.
                """,
            lineTexts: [
                LineMeaning(position: 1, text: "If you are sincere, but not to the end, there will sometimes be confusion, sometimes gathering together. If you call out, then after one grasp of the hand you can laugh again. Regret not. Going is without blame.", interpretation: "Wavering commitment causes confusion. But genuine connection can be restored quickly. Don't hesitate to reach out."),
                LineMeaning(position: 2, text: "Letting oneself be drawn brings good fortune and remains blameless. If one is sincere, it furthers one to bring even a small offering.", interpretation: "Allow yourself to be drawn into the gathering. Even a modest contribution, sincerely given, is valuable."),
                LineMeaning(position: 3, text: "Gathering together amid sighs. Nothing that would further. Going is without blame. Slight humiliation.", interpretation: "Wanting to join but finding no connection brings sighs. Proceeding anyway causes slight embarrassment but no real harm."),
                LineMeaning(position: 4, text: "Great good fortune. No blame.", interpretation: "One gathers people around not for personal gain but in service to the leader. This brings great good fortune and no blame."),
                LineMeaning(position: 5, text: "If in gathering together one has position, this brings no blame. If there are some who are not yet sincerely in the work, sublime and enduring perseverance is needed. Then remorse disappears.", interpretation: "Leading the gathering with legitimate authority. If some remain unconvinced, patient persistence wins them over."),
                LineMeaning(position: 6, text: "Lamenting and sighing, floods of tears. No blame.", interpretation: "Being unable to join the gathering causes deep sorrow. Such genuine grief at exclusion brings no blame.")
            ]
        )
    }
    
    func createHexagram46() -> Hexagram {
        Hexagram(
            id: 46,
            chineseName: "升",
            pinyin: "shēng",
            englishName: "Pushing Upward",
            character: "䷭",
            upperTrigram: .earth,
            lowerTrigram: .wind,
            judgment: """
                PUSHING UPWARD has supreme success.
                One must see the great man.
                Fear not.
                Departure toward the south
                Brings good fortune.
                """,
            image: """
                Within the earth, wood grows:
                The image of PUSHING UPWARD.
                Thus the superior man of devoted character
                Heaps up small things
                In order to achieve something high and great.
                """,
            commentary: """
                The lower trigram, Sun, represents wood; the upper, K'un, represents earth. Wood grows within the earth and works its way up to the light. This pushing upward suggests the effort of rising step by step through devoted work.
                
                Unlike sudden advancement, this is gradual progress through diligent effort. Small accumulations over time lead to great results. The effort requires adaptability and persistence, like a plant that grows toward the light.
                """,
            lineTexts: [
                LineMeaning(position: 1, text: "Pushing upward that meets with confidence brings great good fortune.", interpretation: "The beginning of upward movement is welcomed and trusted. This confident support enables great good fortune."),
                LineMeaning(position: 2, text: "If one is sincere, it furthers one to bring even a small offering. No blame.", interpretation: "Genuine sincerity matters more than grand gestures. Even modest contributions, if sincere, bring no blame."),
                LineMeaning(position: 3, text: "One pushes upward into an empty city.", interpretation: "Advancement meets no resistance. The path forward is clear and unobstructed. Progress is easy."),
                LineMeaning(position: 4, text: "The king offers him Mount Ch'i. Good fortune. No blame.", interpretation: "Recognition comes from the highest authority. The upward journey receives official blessing and support."),
                LineMeaning(position: 5, text: "Perseverance brings good fortune. One pushes upward by steps.", interpretation: "Steady, step-by-step advancement brings good fortune. Don't rush; consistent progress is more reliable than leaps."),
                LineMeaning(position: 6, text: "Pushing upward in darkness. It furthers one to be unremittingly persevering.", interpretation: "At the height of the climb, visibility is lost. Only unwavering persistence prevents a fall. Keep going despite uncertainty.")
            ]
        )
    }
    
    func createHexagram47() -> Hexagram {
        Hexagram(
            id: 47,
            chineseName: "困",
            pinyin: "kùn",
            englishName: "Oppression (Exhaustion)",
            character: "䷮",
            upperTrigram: .lake,
            lowerTrigram: .water,
            judgment: """
                OPPRESSION. Success. Perseverance.
                The great man brings about good fortune.
                No blame.
                When one has something to say,
                It is not believed.
                """,
            image: """
                There is no water in the lake:
                The image of EXHAUSTION.
                Thus the superior man stakes his life
                On following his will.
                """,
            commentary: """
                The lake is above, water below; the lake is empty, drained away. Exhaustion of resources is indicated. This is a time of adversity when one's words are not believed and actions are blocked.
                
                Yet success remains possible for the great person who maintains inner constancy. The exhaustion is of external resources, not inner character. One must draw on inner reserves and wait for conditions to improve. True character shows itself in adversity.
                """,
            lineTexts: [
                LineMeaning(position: 1, text: "One sits oppressed under a bare tree and strays into a gloomy valley. For three years one sees nothing.", interpretation: "Deep depression and confusion. One has lost the way and cannot find it. This period of darkness lasts a long time."),
                LineMeaning(position: 2, text: "One is oppressed while at meat and drink. The man with the scarlet knee bands is just coming. It furthers one to offer sacrifice. To set forth brings misfortune. No blame.", interpretation: "Oppression in the midst of comfort. Help is approaching. Make spiritual preparations rather than external action."),
                LineMeaning(position: 3, text: "A man permits himself to be oppressed by stone and leans on thorns and thistles. He enters his house and does not see his wife. Misfortune.", interpretation: "Oppressed by rigid external circumstances and finding no comfort at home. Complete isolation and misfortune."),
                LineMeaning(position: 4, text: "He comes very quietly, oppressed in a golden carriage. Humiliation, but the end is reached.", interpretation: "One in a privileged position is still oppressed, approaching carefully and somewhat shamefully. But the difficulty reaches its end."),
                LineMeaning(position: 5, text: "His nose and feet are cut off. Oppression at the hands of the man with the purple knee bands. Joy comes softly. It furthers one to make offerings and libations.", interpretation: "Severe oppression from those in authority. Yet gentle joy approaches. Spiritual practices bring relief."),
                LineMeaning(position: 6, text: "He is oppressed by creeping vines. He moves uncertainly and says, 'Movement brings remorse.' If one feels remorse over this and makes a start, good fortune comes.", interpretation: "Entangled in difficulties and hesitant to move. But recognizing this paralysis and making a fresh start brings good fortune.")
            ]
        )
    }
    
    func createHexagram48() -> Hexagram {
        Hexagram(
            id: 48,
            chineseName: "井",
            pinyin: "jǐng",
            englishName: "The Well",
            character: "䷯",
            upperTrigram: .water,
            lowerTrigram: .wind,
            judgment: """
                THE WELL. The town may be changed,
                But the well cannot be changed.
                It neither decreases nor increases.
                They come and go and draw from the well.
                If one gets down almost to the water
                And the rope does not go all the way,
                Or the jug breaks, it brings misfortune.
                """,
            image: """
                Water over wood: the image of THE WELL.
                Thus the superior man encourages the people at their work,
                And exhorts them to help one another.
                """,
            commentary: """
                The well is the source of life for a community. It remains constant while everything else changes. Cities may move, populations may shift, but the wells remain where the water is.
                
                This hexagram refers to the inexhaustible source of nourishment, both physical and spiritual. But the well must be properly maintained and used. If the rope is too short or the vessel breaks, the water cannot be drawn—the resource is there but cannot be accessed. Care and diligence are required.
                """,
            lineTexts: [
                LineMeaning(position: 1, text: "One does not drink the mud of the well. No animals come to an old well.", interpretation: "A neglected well becomes unusable. If the source of nourishment is not maintained, no one benefits from it."),
                LineMeaning(position: 2, text: "At the well hole one shoots fishes. The jug is broken and leaks.", interpretation: "The well has good water but is being misused. The vessel for drawing is damaged. Capabilities exist but are wasted."),
                LineMeaning(position: 3, text: "The well is cleaned, but no one drinks from it. This is my heart's sorrow, for one might draw from it. If the king were clear-minded, good fortune might be enjoyed in common.", interpretation: "The source is pure and ready, but no one uses it. This is a tragedy. If those in authority recognized its value, everyone would benefit."),
                LineMeaning(position: 4, text: "The well is being lined. No blame.", interpretation: "The well is being repaired and maintained. No water can be drawn during renovation, but this maintenance brings no blame."),
                LineMeaning(position: 5, text: "In the well there is a clear, cold spring from which one can drink.", interpretation: "The well functions perfectly. The source is pure and accessible. Genuine nourishment is available for all."),
                LineMeaning(position: 6, text: "One draws from the well without hindrance. It is dependable. Supreme good fortune.", interpretation: "The well serves freely and reliably. Nothing blocks access to its inexhaustible nourishment. Supreme good fortune for all who draw from it.")
            ]
        )
    }
}
