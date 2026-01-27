import Foundation

// MARK: - Hexagrams 17-32

extension HexagramLibrary {
    
    func createHexagram17() -> Hexagram {
        Hexagram(
            id: 17,
            chineseName: "隨",
            pinyin: "suí",
            englishName: "Following",
            character: "䷐",
            upperTrigram: .lake,
            lowerTrigram: .thunder,
            judgment: """
                FOLLOWING has supreme success.
                Perseverance furthers. No blame.
                """,
            image: """
                Thunder in the middle of the lake:
                The image of FOLLOWING.
                Thus the superior man at nightfall
                Goes indoors for rest and recuperation.
                """,
            commentary: """
                In order to obtain a following one must first know how to adapt oneself. If a man would rule he must first learn to serve. To follow others is not in itself something inferior; indeed, by adapting oneself to circumstances, one gains the insight and flexibility necessary to take the lead.
                
                The joyous mood of the lake, triggered by the thunder below, symbolizes the idea of following. Following in the sense of adaptation to what the time demands. The successful leader adapts to circumstances.
                """,
            lineTexts: [
                LineMeaning(position: 1, text: "The standard is changing. Perseverance brings good fortune. To go out of the door in company produces deeds.", interpretation: "Change in one's orientation is needed. Be flexible about relationships but maintain inner constancy. Seek company for undertakings."),
                LineMeaning(position: 2, text: "If one clings to the little boy, one loses the strong man.", interpretation: "One must choose what to follow carefully. Attaching to the lesser means losing the greater. Consider priorities."),
                LineMeaning(position: 3, text: "If one clings to the strong man, one loses the little boy. Through following one finds what one seeks. It furthers one to remain persevering.", interpretation: "Choosing to follow the worthy means letting go of lesser connections. This choice leads to finding what is truly sought."),
                LineMeaning(position: 4, text: "Following creates success. Perseverance brings misfortune. To go one's way with sincerity brings clarity. How could there be blame in this?", interpretation: "Though following brings success, blind persistence can be harmful. Acting with sincerity reveals the right path."),
                LineMeaning(position: 5, text: "Sincere in the good. Good fortune.", interpretation: "Genuine devotion to what is good and true brings good fortune. Authenticity in following worthy aims leads to success."),
                LineMeaning(position: 6, text: "He meets with firm allegiance and is still further bound. The king introduces him to the Western Mountain.", interpretation: "The deepest following brings lasting connection. Such devotion is recognized and honored at the highest levels.")
            ]
        )
    }
    
    func createHexagram18() -> Hexagram {
        Hexagram(
            id: 18,
            chineseName: "蠱",
            pinyin: "gǔ",
            englishName: "Work on What Has Been Spoiled (Decay)",
            character: "䷑",
            upperTrigram: .mountain,
            lowerTrigram: .wind,
            judgment: """
                WORK ON WHAT HAS BEEN SPOILED
                Has supreme success.
                It furthers one to cross the great water.
                Before the starting point, three days.
                After the starting point, three days.
                """,
            image: """
                The wind blows low on the mountain:
                The image of DECAY.
                Thus the superior man stirs up the people
                And strengthens their spirit.
                """,
            commentary: """
                What has been spoiled through human fault can be made good again through human work. It is not immutable fate that has caused the state of corruption, but rather the abuse of human freedom. Work toward improvement always has a prospect of success.
                
                The hexagram refers to what has decayed through neglect and must be corrected. The wind at the foot of the mountain cannot disperse decay; only when it rises can it do so. Similarly, social reform requires arousing people's spirits.
                """,
            lineTexts: [
                LineMeaning(position: 1, text: "Setting right what has been spoiled by the father. If there is a son, no blame rests upon the departed father. Danger. In the end good fortune.", interpretation: "Correcting inherited problems is delicate but necessary. Handle the situation carefully to honor predecessors while making needed changes."),
                LineMeaning(position: 2, text: "Setting right what has been spoiled by the mother. One must not be too persevering.", interpretation: "Correcting problems created by weak leadership requires gentle handling. Don't be too forceful in making changes."),
                LineMeaning(position: 3, text: "Setting right what has been spoiled by the father. There will be a little remorse. No great blame.", interpretation: "Vigorous reform of inherited problems may create some friction but no serious harm. Act with energy while accepting minor difficulties."),
                LineMeaning(position: 4, text: "Tolerating what has been spoiled by the father. In continuing one sees humiliation.", interpretation: "Failing to address inherited problems leads to increasing shame. Tolerating decay causes it to worsen."),
                LineMeaning(position: 5, text: "Setting right what has been spoiled by the father. One meets with praise.", interpretation: "Successfully correcting inherited problems brings honor. The effort is recognized and appreciated by others."),
                LineMeaning(position: 6, text: "He does not serve kings and princes, sets himself higher goals.", interpretation: "Rather than serving in corrupt systems, one may choose to pursue higher aims independently. Sometimes the best reform is to model better ways.")
            ]
        )
    }
    
    func createHexagram19() -> Hexagram {
        Hexagram(
            id: 19,
            chineseName: "臨",
            pinyin: "lín",
            englishName: "Approach",
            character: "䷒",
            upperTrigram: .earth,
            lowerTrigram: .lake,
            judgment: """
                APPROACH has supreme success.
                Perseverance furthers.
                When the eighth month comes,
                There will be misfortune.
                """,
            image: """
                The earth above the lake:
                The image of APPROACH.
                Thus the superior man is inexhaustible
                In his will to teach,
                And without limits
                In his tolerance and protection of the people.
                """,
            commentary: """
                The hexagram as a whole points to a time of joyous, hopeful progress. Spring is approaching. Joy and forbearance bring high and low nearer together. Success is certain. But we must work with determination and perseverance to make full use of the propitiousness of the time.
                
                And there is still another meaning: a warning that what now is advancing will eventually recede—specifically in the eighth month when the dark forces will once again be ascendant. One must think of this change in good time.
                """,
            lineTexts: [
                LineMeaning(position: 1, text: "Joint approach. Perseverance brings good fortune.", interpretation: "Approaching together with others in a common cause brings success. Mutual commitment and steady effort lead to good fortune."),
                LineMeaning(position: 2, text: "Joint approach. Good fortune. Everything furthers.", interpretation: "The approach strengthens and everything becomes favorable. This is the optimal position for moving forward together."),
                LineMeaning(position: 3, text: "Comfortable approach. Nothing that would further. If one is induced to grieve over it, one becomes free of blame.", interpretation: "Approaching from a position of complacency brings no benefit. Recognition of this error and genuine regret lead to correction."),
                LineMeaning(position: 4, text: "Complete approach. No blame.", interpretation: "Approaching wholeheartedly and without reservation is correct. Full commitment brings no blame."),
                LineMeaning(position: 5, text: "Wise approach. This is right for a great prince. Good fortune.", interpretation: "Approaching with wisdom—selecting the right helpers and maintaining proper delegation—leads to good fortune. This is leadership at its best."),
                LineMeaning(position: 6, text: "Great-hearted approach. Good fortune. No blame.", interpretation: "Approaching with magnanimity and generosity of spirit brings good fortune. Genuine benevolence overcomes any remaining obstacles.")
            ]
        )
    }
    
    func createHexagram20() -> Hexagram {
        Hexagram(
            id: 20,
            chineseName: "觀",
            pinyin: "guān",
            englishName: "Contemplation (View)",
            character: "䷓",
            upperTrigram: .wind,
            lowerTrigram: .earth,
            judgment: """
                CONTEMPLATION. The ablution has been made,
                But not yet the offering.
                Full of trust they look up to him.
                """,
            image: """
                The wind blows over the earth:
                The image of CONTEMPLATION.
                Thus the kings of old visited the regions of the world,
                Contemplated the people,
                And gave them instruction.
                """,
            commentary: """
                A slight variation changes the meaning of this hexagram significantly. The image of the wind blowing over the earth suggests both observation and influence. One contemplates the nature of things and is oneself contemplated.
                
                The point made here is that contemplation must be sincere, not merely external. Like the ritual ablution that prepares for sacrifice, inner purification precedes genuine insight. When contemplation is authentic, others naturally respond with trust.
                """,
            lineTexts: [
                LineMeaning(position: 1, text: "Boy-like contemplation. For an inferior man, no blame. For a superior man, humiliation.", interpretation: "Superficial, childish observation is acceptable for those of limited understanding, but not for one with higher aspirations. Develop deeper insight."),
                LineMeaning(position: 2, text: "Contemplation through the crack of the door. Furthering for the perseverance of a woman.", interpretation: "Narrow, limited perspective may suffice for one in a restricted position, but broader vision is needed for active engagement with the world."),
                LineMeaning(position: 3, text: "Contemplation of my life decides the choice between advance and retreat.", interpretation: "Self-examination reveals whether to move forward or step back. Study your own life to determine the right course of action."),
                LineMeaning(position: 4, text: "Contemplation of the light of the kingdom. It furthers one to exert influence as the guest of a king.", interpretation: "Understanding the ways of leadership enables one to serve effectively. Insight into power structures allows beneficial influence."),
                LineMeaning(position: 5, text: "Contemplation of my life. The superior man is without blame.", interpretation: "Those in positions of influence must examine themselves constantly. When one's example is worthy, there is no blame."),
                LineMeaning(position: 6, text: "Contemplation of his life. The superior man is without blame.", interpretation: "At the highest level, one observes the universal patterns of life itself. Understanding these principles, the sage acts without error.")
            ]
        )
    }
    
    func createHexagram21() -> Hexagram {
        Hexagram(
            id: 21,
            chineseName: "噬嗑",
            pinyin: "shì kè",
            englishName: "Biting Through",
            character: "䷔",
            upperTrigram: .fire,
            lowerTrigram: .thunder,
            judgment: """
                BITING THROUGH has success.
                It is favorable to let justice be administered.
                """,
            image: """
                Thunder and lightning:
                The image of BITING THROUGH.
                Thus the kings of former times
                Made firm the laws
                Through clearly defined penalties.
                """,
            commentary: """
                This hexagram represents an open mouth with an obstruction between the teeth. As a result the lips cannot meet. To achieve union the obstacle must be energetically bitten through.
                
                The hexagram refers to overcoming obstacles through decisive action. Thunder and lightning combine to form a powerful image. Similarly, when dealing with obstinate wrongdoers, energetic measures are required. The laws must be clear and their enforcement certain.
                """,
            lineTexts: [
                LineMeaning(position: 1, text: "His feet are fastened in the stocks, so that his toes disappear. No blame.", interpretation: "A minor offense receives a small punishment that prevents further transgression. Early correction prevents greater problems."),
                LineMeaning(position: 2, text: "Bites through tender meat, so that his nose disappears. No blame.", interpretation: "When dealing with clear wrongdoing, decisive action comes easily. Even if it seems excessive, no blame results."),
                LineMeaning(position: 3, text: "Bites on old dried meat and strikes on something poisonous. Slight humiliation. No blame.", interpretation: "An old, difficult case is encountered. There may be some unpleasantness, but persisting through the difficulty brings no blame."),
                LineMeaning(position: 4, text: "Bites on dried gristly meat. Receives metal arrows. It furthers one to be mindful of difficulties and to be persevering. Good fortune.", interpretation: "Dealing with a tough, obstinate case requires strength and persistence. Mindfulness of the difficulty and unwavering resolve lead to success."),
                LineMeaning(position: 5, text: "Bites on dried lean meat. Receives yellow gold. Perseveringly aware of danger. No blame.", interpretation: "Though the task is difficult, one maintains inner correctness. Remaining aware of dangers while persevering brings success without blame."),
                LineMeaning(position: 6, text: "His neck is fastened in the wooden cangue, so that his ears disappear. Misfortune.", interpretation: "One who refuses to learn from warnings eventually receives severe punishment. Repeated offenses lead to harsh consequences.")
            ]
        )
    }
    
    func createHexagram22() -> Hexagram {
        Hexagram(
            id: 22,
            chineseName: "賁",
            pinyin: "bì",
            englishName: "Grace",
            character: "䷕",
            upperTrigram: .mountain,
            lowerTrigram: .fire,
            judgment: """
                GRACE has success.
                In small matters
                It is favorable to undertake something.
                """,
            image: """
                Fire at the foot of the mountain:
                The image of GRACE.
                Thus does the superior man proceed
                When clearing up current affairs.
                But he dare not decide controversial issues in this way.
                """,
            commentary: """
                Grace—beauty of form—is necessary in any union if it is to be well ordered and pleasing. Grace brings success. However, it is not the essential or fundamental thing; it is only the ornament and therefore to be used only sparingly and in small matters.
                
                The fire illuminates the mountain from below, bringing out its form in beauty. But light is not the mountain itself. Likewise, in human affairs, form and beauty have their place, but should not be confused with substance.
                """,
            lineTexts: [
                LineMeaning(position: 1, text: "He lends grace to his toes, leaves the carriage, and walks.", interpretation: "One of modest position should adorn oneself modestly. Preferring to walk rather than ride shows appropriate simplicity."),
                LineMeaning(position: 2, text: "Lends grace to the beard on his chin.", interpretation: "The beard moves with the chin; it has no independent movement. This suggests adornment that follows the essential, not leading it."),
                LineMeaning(position: 3, text: "Graceful and moist. Constant perseverance brings good fortune.", interpretation: "A pleasant, beautiful situation—but don't be lulled into complacency. Maintain steady effort despite pleasant circumstances."),
                LineMeaning(position: 4, text: "Grace or simplicity? A white horse comes as if on wings. He is not a robber; he will woo at the right time.", interpretation: "The choice between ornament and simplicity faces you. What appears threatening may actually be a sincere offer. Wait and discern."),
                LineMeaning(position: 5, text: "Grace in the hills and gardens. The roll of silk is meager and small. Humiliation, but in the end good fortune.", interpretation: "Simple, genuine connection is preferred to elaborate display. Though resources seem modest, sincerity ultimately brings good fortune."),
                LineMeaning(position: 6, text: "Simple grace. No blame.", interpretation: "At the highest level, grace returns to simplicity. All ornamentation is stripped away, leaving pure essence. This is without blame.")
            ]
        )
    }
    
    func createHexagram23() -> Hexagram {
        Hexagram(
            id: 23,
            chineseName: "剝",
            pinyin: "bō",
            englishName: "Splitting Apart",
            character: "䷖",
            upperTrigram: .mountain,
            lowerTrigram: .earth,
            judgment: """
                SPLITTING APART. It does not further one
                To go anywhere.
                """,
            image: """
                The mountain rests on the earth:
                The image of SPLITTING APART.
                Thus those above can ensure their position
                Only by giving generously to those below.
                """,
            commentary: """
                This hexagram pictures a house that is about to topple. The five yielding lines are about to displace the one strong line at the top. The dark forces are about to gain ascendancy.
                
                This is a time of decay and dissolution. It does not further to undertake anything. One should simply wait quietly and let the process run its course. The wise person recognizes this unfavorable time and withdraws, strengthening inner resources for the future.
                """,
            lineTexts: [
                LineMeaning(position: 1, text: "The leg of the bed is split. Those who persevere are destroyed. Misfortune.", interpretation: "The foundation is being undermined by inferior elements. Those who remain stubbornly in position are harmed."),
                LineMeaning(position: 2, text: "The bed is split at the edge. Those who persevere are destroyed. Misfortune.", interpretation: "The destruction spreads. Isolation grows as allies are lost. Continuing resistance brings misfortune."),
                LineMeaning(position: 3, text: "He splits with them. No blame.", interpretation: "Breaking away from the destructive process is necessary. Separating from harmful elements brings no blame."),
                LineMeaning(position: 4, text: "The bed is split up to the skin. Misfortune.", interpretation: "The destruction has reached the vital point. The situation has become critical and painful."),
                LineMeaning(position: 5, text: "A shoal of fishes. Favor comes through the court ladies. Everything acts to further.", interpretation: "By winning over those close to power through graciousness, the destructive process can be reversed. Gentle influence brings benefit."),
                LineMeaning(position: 6, text: "There is a large fruit still uneaten. The superior man receives a carriage. The house of the inferior man is split apart.", interpretation: "The cycle completes. A seed of the good remains and the worthy are restored while the unworthy are dispersed. Renewal follows decay.")
            ]
        )
    }
    
    func createHexagram24() -> Hexagram {
        Hexagram(
            id: 24,
            chineseName: "復",
            pinyin: "fù",
            englishName: "Return (The Turning Point)",
            character: "䷗",
            upperTrigram: .earth,
            lowerTrigram: .thunder,
            judgment: """
                RETURN. Success.
                Going out and coming in without error.
                Friends come without blame.
                To and fro goes the way.
                On the seventh day comes return.
                It furthers one to have somewhere to go.
                """,
            image: """
                Thunder within the earth:
                The image of THE TURNING POINT.
                Thus the kings of antiquity closed the passes
                At the time of solstice.
                Merchants and strangers did not go about,
                And the ruler did not travel through the provinces.
                """,
            commentary: """
                After a time of decay comes the turning point. The powerful light that has been banished returns. There is movement, but it is not brought about by force. The upper trigram K'un is characterized by devotion; thus the movement is natural, arising spontaneously.
                
                This hexagram is associated with the eleventh month, the winter solstice, when the dark forces have reached their limit and the light begins its return. This is a time of new beginnings.
                """,
            lineTexts: [
                LineMeaning(position: 1, text: "Return from a short distance. No need for remorse. Great good fortune.", interpretation: "Catching oneself early in deviation requires only a small correction. Prompt return to the right path brings great good fortune."),
                LineMeaning(position: 2, text: "Quiet return. Good fortune.", interpretation: "Returning through gentle self-examination, perhaps influenced by good examples nearby. This brings good fortune."),
                LineMeaning(position: 3, text: "Repeated return. Danger. No blame.", interpretation: "One who repeatedly strays and returns shows instability. Though dangerous, sincere efforts to return still bring no ultimate blame."),
                LineMeaning(position: 4, text: "Walking in the midst of others, one returns alone.", interpretation: "One finds the strength to return to the right path despite the influence of others going a different direction. Individual integrity."),
                LineMeaning(position: 5, text: "Noble-hearted return. No remorse.", interpretation: "Return motivated by genuine inner recognition of what is right. No regret follows such wholehearted turning."),
                LineMeaning(position: 6, text: "Missing the return. Misfortune. Misfortune from within and without. If armies are set marching in this way, one will in the end suffer a great defeat, disastrous for the ruler of the country. For ten years it will not be possible to attack again.", interpretation: "Missing the opportunity to return leads to disaster. The consequences of not heeding the turning point are severe and lasting.")
            ]
        )
    }
    
    func createHexagram25() -> Hexagram {
        Hexagram(
            id: 25,
            chineseName: "无妄",
            pinyin: "wú wàng",
            englishName: "Innocence (The Unexpected)",
            character: "䷘",
            upperTrigram: .heaven,
            lowerTrigram: .thunder,
            judgment: """
                INNOCENCE. Supreme success.
                Perseverance furthers.
                If someone is not as he should be,
                He has misfortune,
                And it does not further him
                To undertake anything.
                """,
            image: """
                Under heaven thunder rolls:
                All things attain the natural state of innocence.
                Thus the kings of old,
                Rich in virtue, and in harmony with the time,
                Fostered and nourished all beings.
                """,
            commentary: """
                Man has received from heaven a nature innately good, to guide him in all his movements. By devotion to this divine spirit within himself, he attains an unsullied innocence that leads him to do right with instinctive sureness and without any ulterior thought of reward and personal advantage.
                
                This instinctive certainty brings about supreme success and furthers through perseverance. However, not everything instinctive is necessarily good—only that which is right according to the will of heaven. Without this correctness, there is misfortune.
                """,
            lineTexts: [
                LineMeaning(position: 1, text: "Innocent behavior brings good fortune.", interpretation: "Acting from genuine innocence and natural instinct leads to good fortune. Trust in inherent goodness."),
                LineMeaning(position: 2, text: "If one does not count on the harvest while plowing, nor on the use of the ground while clearing it, it furthers one to undertake something.", interpretation: "Work without calculating results. When actions are performed for their own sake without ulterior motive, success follows naturally."),
                LineMeaning(position: 3, text: "Undeserved misfortune. The cow that was tethered by someone is the wanderer's gain, the citizen's loss.", interpretation: "Sometimes misfortune comes despite innocent conduct. One person's loss may be another's gain through no fault of either. Accept such events."),
                LineMeaning(position: 4, text: "He who can be persevering remains without blame.", interpretation: "Steadfast adherence to inner truth protects against external pressures. What genuinely belongs to you cannot be lost."),
                LineMeaning(position: 5, text: "Use no medicine for a sickness incurred through no fault of your own. It will pass of itself.", interpretation: "Problems that arise without personal fault will resolve themselves naturally. Forced interventions may make things worse."),
                LineMeaning(position: 6, text: "Innocent action brings misfortune. Nothing furthers.", interpretation: "When the time is not right, even innocent action can bring misfortune. Wait for a more favorable moment rather than forcing action.")
            ]
        )
    }
    
    func createHexagram26() -> Hexagram {
        Hexagram(
            id: 26,
            chineseName: "大畜",
            pinyin: "dà xù",
            englishName: "The Taming Power of the Great",
            character: "䷙",
            upperTrigram: .mountain,
            lowerTrigram: .heaven,
            judgment: """
                THE TAMING POWER OF THE GREAT.
                Perseverance furthers.
                Not eating at home brings good fortune.
                It furthers one to cross the great water.
                """,
            image: """
                Heaven within the mountain:
                The image of THE TAMING POWER OF THE GREAT.
                Thus the superior man acquaints himself with many sayings of antiquity
                And many deeds of the past,
                In order to strengthen his character thereby.
                """,
            commentary: """
                The Creative is tamed by Kěn, Keeping Still. This produces great power, different from and more significant than that yielded by the Taming Power of the Small. Here the restraint is the mountain, the spirit of the sage.
                
                Great energy must be held in check by a strong will and accumulated for great work. The hexagram suggests a time of study and preparation, of building up resources both material and spiritual for significant undertakings ahead.
                """,
            lineTexts: [
                LineMeaning(position: 1, text: "Danger is at hand. It furthers one to desist.", interpretation: "Obstacles and opposition are present. This is not the time to push forward. Restraint and patience are called for."),
                LineMeaning(position: 2, text: "The axletrees are taken from the wagon.", interpretation: "Progress is prevented. The means of advancing are removed. Accept this restraint rather than fighting against it."),
                LineMeaning(position: 3, text: "A good horse that follows others. Awareness of danger, with perseverance, furthers. Practice chariot driving and armed defense daily. It furthers one to have somewhere to go.", interpretation: "Progress becomes possible when following a worthy path. Maintain vigilance and continue daily practice. Having a clear goal is beneficial."),
                LineMeaning(position: 4, text: "The headboard of a young bull. Great good fortune.", interpretation: "Restraining force at an early stage, before it becomes difficult to control, brings great good fortune. Preventive measures are most effective."),
                LineMeaning(position: 5, text: "The tusk of a gelded boar. Good fortune.", interpretation: "Wild energy is redirected rather than forcefully suppressed. Indirect methods of control bring good fortune."),
                LineMeaning(position: 6, text: "One attains the way of heaven. Success.", interpretation: "The accumulated power is fully realized. Restraint has built the strength needed for great accomplishment. Heaven's way is attained.")
            ]
        )
    }
    
    func createHexagram27() -> Hexagram {
        Hexagram(
            id: 27,
            chineseName: "頤",
            pinyin: "yí",
            englishName: "The Corners of the Mouth (Providing Nourishment)",
            character: "䷚",
            upperTrigram: .mountain,
            lowerTrigram: .thunder,
            judgment: """
                THE CORNERS OF THE MOUTH.
                Perseverance brings good fortune.
                Pay heed to the providing of nourishment
                And to what a man seeks
                To fill his own mouth with.
                """,
            image: """
                At the foot of the mountain, thunder:
                The image of PROVIDING NOURISHMENT.
                Thus the superior man is careful of his words
                And temperate in eating and drinking.
                """,
            commentary: """
                This hexagram is a picture of an open mouth. The top and bottom lines are solid, representing the lips; the middle lines are broken, representing the open mouth. The image refers to nourishment of oneself and others.
                
                There are two aspects: the nourishment of others through service and teaching, and the nourishment of oneself. What one takes in—whether food for the body or ideas for the mind—determines one's character and fate.
                """,
            lineTexts: [
                LineMeaning(position: 1, text: "You let your magic tortoise go, and look at me with the corners of your mouth drooping. Misfortune.", interpretation: "Abandoning your own inner resources to envy others leads to misfortune. Do not let go of what is truly valuable for superficial gains."),
                LineMeaning(position: 2, text: "Turning to the summit for nourishment, deviating from the path to seek nourishment from the hill. Continuing to do this brings misfortune.", interpretation: "Seeking nourishment from improper sources leads to misfortune. Maintain proper relationships and sources of support."),
                LineMeaning(position: 3, text: "Turning away from nourishment. Perseverance brings misfortune. Do not act thus for ten years. Nothing serves to further.", interpretation: "Refusing proper nourishment and pursuing empty satisfactions leads nowhere. Such a path brings nothing but regret."),
                LineMeaning(position: 4, text: "Turning to the summit for provision of nourishment brings good fortune. Spying about with sharp eyes like a tiger with insatiable craving. No blame.", interpretation: "Seeking nourishment from above for the purpose of benefiting others below is fortunate. Intense searching for wisdom to share is without blame."),
                LineMeaning(position: 5, text: "Turning away from the path. To remain persevering brings good fortune. One should not cross the great water.", interpretation: "Recognizing one's limitations and working within them brings good fortune. This is not the time for great undertakings."),
                LineMeaning(position: 6, text: "The source of nourishment. Awareness of danger brings good fortune. It furthers one to cross the great water.", interpretation: "Being the source of nourishment for others is a great responsibility. With constant awareness of the dangers involved, one can successfully undertake great things.")
            ]
        )
    }
    
    func createHexagram28() -> Hexagram {
        Hexagram(
            id: 28,
            chineseName: "大過",
            pinyin: "dà guò",
            englishName: "Preponderance of the Great",
            character: "䷛",
            upperTrigram: .lake,
            lowerTrigram: .wind,
            judgment: """
                PREPONDERANCE OF THE GREAT.
                The ridgepole sags to the breaking point.
                It furthers one to have somewhere to go.
                Success.
                """,
            image: """
                The lake rises above the trees:
                The image of PREPONDERANCE OF THE GREAT.
                Thus the superior man, when he stands alone,
                Is unconcerned,
                And if he has to renounce the world,
                He is undaunted.
                """,
            commentary: """
                This hexagram indicates a time when something extraordinary must be done. The ridgepole is thick and strong at the center but weak at the ends—like a situation where the main body is strong but the supports are weak.
                
                Extraordinary times require extraordinary measures. The situation is critical but not hopeless. Bold action is needed. One must have a definite goal and move toward it with resolution. Only through exceptional effort can the situation be rectified.
                """,
            lineTexts: [
                LineMeaning(position: 1, text: "To spread white rushes underneath. No blame.", interpretation: "Exceptional caution and care at the beginning of a critical undertaking. Extra protection prevents mishap. No blame in being overly careful."),
                LineMeaning(position: 2, text: "A dry poplar sprouts at the root. An older man takes a young wife. Everything furthers.", interpretation: "New life from an unlikely source. Unexpected renewal occurs. Unconventional arrangements that restore vitality are beneficial."),
                LineMeaning(position: 3, text: "The ridgepole sags to the breaking point. Misfortune.", interpretation: "The strain is too great. Refusing to bend or adapt under pressure leads to a break. Misfortune follows rigidity in extraordinary times."),
                LineMeaning(position: 4, text: "The ridgepole is braced. Good fortune. If there are ulterior motives, it is humiliating.", interpretation: "Support is provided to shore up the critical situation. This brings good fortune—unless done for selfish reasons."),
                LineMeaning(position: 5, text: "A withered poplar puts forth flowers. An older woman takes a young husband. No blame. No praise.", interpretation: "A last flowering without future. An aging situation produces beauty but not lasting vitality. Neither praised nor blamed."),
                LineMeaning(position: 6, text: "One must go through the water. It goes over one's head. Misfortune. No blame.", interpretation: "One sacrifices oneself for a cause, going beyond what can be survived. Though misfortune results, there is no blame in such noble sacrifice.")
            ]
        )
    }
    
    func createHexagram29() -> Hexagram {
        Hexagram(
            id: 29,
            chineseName: "坎",
            pinyin: "kǎn",
            englishName: "The Abysmal (Water)",
            character: "䷜",
            upperTrigram: .water,
            lowerTrigram: .water,
            judgment: """
                The Abysmal repeated.
                If you are sincere, you have success in your heart,
                And whatever you do succeeds.
                """,
            image: """
                Water flows on and reaches the goal:
                The image of the Abysmal repeated.
                Thus the superior man walks in lasting virtue
                And carries on the business of teaching.
                """,
            commentary: """
                This hexagram represents water doubled—one dangerous abyss following another. It symbolizes objective danger as well as subjective states of difficulty: the soul locked in the body, the light held in the dark.
                
                The way out of danger lies in working through it, not avoiding it. Like water that flows on persistently and fills up all the places that block its progress, one must persevere with sincerity. Water shows the way: it achieves success by holding true to its nature.
                """,
            lineTexts: [
                LineMeaning(position: 1, text: "Repetition of the Abysmal. In the abyss one falls into a pit. Misfortune.", interpretation: "When danger becomes familiar, one can fall into the habit of danger. Complacency in difficult circumstances leads to further misfortune."),
                LineMeaning(position: 2, text: "The abyss is dangerous. One should strive to attain small things only.", interpretation: "In the midst of danger, aim for small, achievable goals. Do not attempt great things; focus on survival and small gains."),
                LineMeaning(position: 3, text: "Forward and backward, abyss on abyss. In danger like this, pause at first and wait; otherwise you will fall into a pit in the abyss. Do not act in this way.", interpretation: "Danger in every direction. Movement in any direction brings more danger. Wait until a genuine opportunity for escape presents itself."),
                LineMeaning(position: 4, text: "A jug of wine, a bowl of rice with it; earthen vessels simply handed in through the window. There is certainly no blame in this.", interpretation: "In times of danger, sincerity matters more than ceremony. Simple, genuine offerings suffice. Maintain integrity without pretense."),
                LineMeaning(position: 5, text: "The abyss is not filled to overflowing; it is filled only to the rim. No blame.", interpretation: "The danger has reached its limit but not exceeded it. One achieves balance, containing the danger without being overwhelmed."),
                LineMeaning(position: 6, text: "Bound with cords and ropes, shut in between thorn-hedged prison walls: for three years one does not find the way. Misfortune.", interpretation: "One who persists in wrong ways during danger becomes truly trapped. Prolonged confinement results from repeated errors.")
            ]
        )
    }
    
    func createHexagram30() -> Hexagram {
        Hexagram(
            id: 30,
            chineseName: "離",
            pinyin: "lí",
            englishName: "The Clinging, Fire",
            character: "䷝",
            upperTrigram: .fire,
            lowerTrigram: .fire,
            judgment: """
                THE CLINGING. Perseverance furthers.
                It brings success.
                Care of the cow brings good fortune.
                """,
            image: """
                That which is bright rises twice:
                The image of FIRE.
                Thus the great man, by perpetuating this brightness,
                Illumines the four quarters of the world.
                """,
            commentary: """
                This hexagram is made up of two Li trigrams—fire clinging to what it burns, light clinging to what it illuminates. The yielding element is in the center and clings to what is strong above and below.
                
                What is dark clings to what is light and so enhances the brightness of the latter. What is light and clear depends on something to which it can cling in order to produce lasting brightness. The image suggests dependence and the proper way of depending.
                """,
            lineTexts: [
                LineMeaning(position: 1, text: "The footprints run crisscross. If one is serious, no blame.", interpretation: "At the start of activity, confusion is natural. Maintain composure and seriousness to find the way through initial disorder."),
                LineMeaning(position: 2, text: "Yellow light. Supreme good fortune.", interpretation: "The light finds its proper measure—neither too bright nor too dim. This balanced radiance brings supreme good fortune."),
                LineMeaning(position: 3, text: "In the light of the setting sun, men either beat the pot and sing or loudly bewail the approach of old age. Misfortune.", interpretation: "As things decline, some celebrate unwisely while others lament excessively. Neither extreme response is appropriate."),
                LineMeaning(position: 4, text: "Its coming is sudden; it flames up, dies down, is thrown away.", interpretation: "Like a fire that flares up suddenly and then is extinguished, some things have no lasting power. Sudden brilliance often fades quickly."),
                LineMeaning(position: 5, text: "Tears in floods, sighing and lamenting. Good fortune.", interpretation: "Genuine understanding of the impermanence of all things brings sorrow but also wisdom. This leads to good fortune through acceptance."),
                LineMeaning(position: 6, text: "The king uses him to march forth and chastise. Then it is best to kill the leaders and take captive the followers. No blame.", interpretation: "Decisive action to correct evil—removing the leaders while showing mercy to followers—brings no blame. Discriminating force is appropriate.")
            ]
        )
    }
    
    func createHexagram31() -> Hexagram {
        Hexagram(
            id: 31,
            chineseName: "咸",
            pinyin: "xián",
            englishName: "Influence (Wooing)",
            character: "䷞",
            upperTrigram: .lake,
            lowerTrigram: .mountain,
            judgment: """
                INFLUENCE. Success.
                Perseverance furthers.
                To take a maiden to wife brings good fortune.
                """,
            image: """
                A lake on the mountain:
                The image of INFLUENCE.
                Thus the superior man encourages people to approach him
                By his readiness to receive them.
                """,
            commentary: """
                The name of the hexagram means "universal," "to influence," and "to woo." The upper trigram is Dui, the Joyous; the lower is Kěn, Keeping Still. The keeping still of the mountain with the joyous above suggests a condition of mutual attraction.
                
                This hexagram represents the youngest son and youngest daughter in an embrace. The joyous mood of the lake above the immovable mountain creates attraction. Through keeping still within while the joyous mood manifests outwardly, one exerts influence and attracts others naturally.
                """,
            lineTexts: [
                LineMeaning(position: 1, text: "The influence shows itself in the big toe.", interpretation: "The intention to move begins in the smallest way. Initial stirrings of influence or attraction are subtle and at the periphery."),
                LineMeaning(position: 2, text: "The influence shows itself in the calves of the legs. Misfortune. Tarrying brings good fortune.", interpretation: "The urge to move forward precipitously is harmful. Wait until higher direction comes rather than acting from lower impulses."),
                LineMeaning(position: 3, text: "The influence shows itself in the thighs. Holds to that which follows it. To continue is humiliating.", interpretation: "Pursuing what attracts without discernment leads to humiliation. The thighs cannot move independently; following blindly is shameful."),
                LineMeaning(position: 4, text: "Perseverance brings good fortune. Remorse disappears. If a man is agitated in mind, and his thoughts go hither and thither, only those friends on whom he fixes his conscious thoughts will follow.", interpretation: "Steadfastness in influence brings good fortune. Scattered thoughts attract nothing; focused intention draws genuine response."),
                LineMeaning(position: 5, text: "The influence shows itself in the back of the neck. No remorse.", interpretation: "Influence from the depth of one's being, not from superficial attraction. This deep influence is beyond regret."),
                LineMeaning(position: 6, text: "The influence shows itself in the jaws, cheeks, and tongue.", interpretation: "Influence that manifests only in words, not in the heart. Mere talk without genuine feeling has no lasting power.")
            ]
        )
    }
    
    func createHexagram32() -> Hexagram {
        Hexagram(
            id: 32,
            chineseName: "恆",
            pinyin: "héng",
            englishName: "Duration",
            character: "䷟",
            upperTrigram: .thunder,
            lowerTrigram: .wind,
            judgment: """
                DURATION. Success. No blame.
                Perseverance furthers.
                It furthers one to have somewhere to go.
                """,
            image: """
                Thunder and wind: the image of DURATION.
                Thus the superior man stands firm
                And does not change his direction.
                """,
            commentary: """
                This hexagram is the inverse of the preceding one. It represents a man above and a woman below. Thunder moves; wind follows—thus their movements are in accord. Duration is that which moves within the law of its own nature.
                
                The dedicated man embodies duration. His character is stable; he neither surrenders to the opinions of the day nor simply clings to the past. He continues in his established path, adapting to changed conditions while maintaining consistency of purpose.
                """,
            lineTexts: [
                LineMeaning(position: 1, text: "Seeking duration too hastily brings misfortune persistently. Nothing that would further.", interpretation: "Trying to establish permanence too quickly undermines itself. Duration comes through gradual development, not forcing."),
                LineMeaning(position: 2, text: "Remorse disappears.", interpretation: "By finding one's proper measure and staying within it, regret vanishes. Sustainable duration comes from knowing one's limits."),
                LineMeaning(position: 3, text: "He who does not give duration to his character meets with disgrace. Persistent humiliation.", interpretation: "Inconsistency of character leads to shame. One who changes with every circumstance loses respect and self-respect."),
                LineMeaning(position: 4, text: "No game in the field.", interpretation: "Searching for what isn't there wastes effort. Persistence in the wrong direction yields nothing. Change your approach."),
                LineMeaning(position: 5, text: "Giving duration to one's character through perseverance. This is good fortune for a woman, misfortune for a man.", interpretation: "Devoted, consistent following is appropriate in a subordinate role but not in a leading one. Leaders must also initiate."),
                LineMeaning(position: 6, text: "Restlessness as an enduring condition brings misfortune.", interpretation: "Constant agitation cannot be sustained. Taking restlessness as a way of life leads to exhaustion and failure.")
            ]
        )
    }
}
