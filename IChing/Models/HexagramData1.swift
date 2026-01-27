import Foundation

// MARK: - Hexagrams 1-16

extension HexagramLibrary {
    
    func createHexagram1() -> Hexagram {
        Hexagram(
            id: 1,
            chineseName: "乾",
            pinyin: "qián",
            englishName: "The Creative",
            character: "䷀",
            upperTrigram: .heaven,
            lowerTrigram: .heaven,
            judgment: """
                THE CREATIVE works sublime success,
                Furthering through perseverance.
                """,
            image: """
                The movement of heaven is full of power.
                Thus the superior man makes himself strong and untiring.
                """,
            commentary: """
                The first hexagram is made up of six unbroken lines. These unbroken lines stand for the primal power, which is light-giving, active, strong, and of the spirit. The hexagram is consistently strong in character, and since it is without weakness, its essence is power or energy. Its image is heaven. Its energy is represented as unrestricted by any fixed conditions in space and is therefore conceived of as motion. Time is regarded as the basis of this motion. Thus the hexagram includes also the power of time and the power of persisting in time, that is, duration.
                
                The power represented by the hexagram is to be interpreted in a dual sense—in terms of its action on the universe and of its action on the world of men. In relation to the universe, the hexagram expresses the strong, creative action of the Deity. In relation to the human world, it denotes the creative action of the holy man or sage, of the ruler or leader of men, who through his power awakens and develops their higher nature.
                """,
            lineTexts: [
                LineMeaning(position: 1, text: "Hidden dragon. Do not act.", interpretation: "The dragon symbolizes dynamism and power. When it is hidden, the time for action has not yet come. A person of superior character will bide their time in concealment, developing their abilities and waiting for the right moment."),
                LineMeaning(position: 2, text: "Dragon appearing in the field. It furthers one to see the great man.", interpretation: "Here the effects of the light-giving power begin to manifest. This is the time when the great man begins to make himself known. He attracts attention and finds helpers."),
                LineMeaning(position: 3, text: "All day long the superior man is creatively active. At nightfall his mind is still beset with cares. Danger. No blame.", interpretation: "A sphere of influence opens up. Yet there is danger of being torn between the lower and higher worlds. One must remain conscious and alert."),
                LineMeaning(position: 4, text: "Wavering flight over the depths. No blame.", interpretation: "A place of transition has been reached where the way branches off in different directions. The decision to advance or retreat rests with oneself. Either path is appropriate."),
                LineMeaning(position: 5, text: "Flying dragon in the heavens. It furthers one to see the great man.", interpretation: "Here the great man has attained the sphere of the heavenly beings. His influence spreads and becomes visible throughout the world. Everyone who sees him may count himself blessed."),
                LineMeaning(position: 6, text: "Arrogant dragon will have cause to repent.", interpretation: "When one seeks to climb too high, they lose touch with reality. If a person in power does not know how to yield at the right time, they will fall. A warning against overreaching.")
            ]
        )
    }
    
    func createHexagram2() -> Hexagram {
        Hexagram(
            id: 2,
            chineseName: "坤",
            pinyin: "kūn",
            englishName: "The Receptive",
            character: "䷁",
            upperTrigram: .earth,
            lowerTrigram: .earth,
            judgment: """
                THE RECEPTIVE brings about sublime success,
                Furthering through the perseverance of a mare.
                If the superior man undertakes something and tries to lead,
                He goes astray;
                But if he follows, he finds guidance.
                It is favorable to find friends in the west and south,
                To forego friends in the east and north.
                Quiet perseverance brings good fortune.
                """,
            image: """
                The earth's condition is receptive devotion.
                Thus the superior man who has breadth of character
                Carries the outer world.
                """,
            commentary: """
                This hexagram is made up of broken lines only. The broken line represents the dark, yielding, receptive primal power of yin. The attribute of the hexagram is devotion; its image is the earth. It is the perfect complement of The Creative—the complement, not the opposite, for the Receptive does not combat the Creative but completes it. It represents nature in contrast to spirit, earth in contrast to heaven, space as against time, the female-maternal as against the male-paternal.
                
                Applied to human affairs, the principle of this hexagram means that the person in question is not in an independent position but is acting as an assistant. The point is that they should accomplish something—not lead, but through devotion fulfill their role and thus achieve their own fulfillment.
                """,
            lineTexts: [
                LineMeaning(position: 1, text: "When there is hoarfrost underfoot, solid ice is not far off.", interpretation: "Just as hoarfrost signals approaching winter, small signs indicate coming developments. The wise person recognizes these early warnings and prepares accordingly."),
                LineMeaning(position: 2, text: "Straight, square, great. Without purpose, yet nothing remains unfurthered.", interpretation: "The nature of the earth is to receive and support all things without forcing anything. Acting with this natural ease, without ulterior motives, leads to success."),
                LineMeaning(position: 3, text: "Hidden lines. One is able to remain persevering. If by chance you are in the service of a king, seek not works, but bring to completion.", interpretation: "When working in a subordinate position, one should not seek recognition. Complete your tasks faithfully but let others take the credit."),
                LineMeaning(position: 4, text: "A tied-up sack. No blame, no praise.", interpretation: "Times of danger require caution and reserve. Like a sack tied shut, one should maintain silence and restraint. Neither glory nor failure results from this careful approach."),
                LineMeaning(position: 5, text: "A yellow lower garment brings supreme good fortune.", interpretation: "Yellow is the color of the earth and of modesty. One who remains modest and devoted, even when holding a position of responsibility, will experience great good fortune."),
                LineMeaning(position: 6, text: "Dragons fight in the meadow. Their blood is black and yellow.", interpretation: "When the receptive attempts to become the creative, conflict ensues. The yielding principle must not try to dominate, or both sides suffer harm.")
            ]
        )
    }
    
    func createHexagram3() -> Hexagram {
        Hexagram(
            id: 3,
            chineseName: "屯",
            pinyin: "zhūn",
            englishName: "Difficulty at the Beginning",
            character: "䷂",
            upperTrigram: .water,
            lowerTrigram: .thunder,
            judgment: """
                DIFFICULTY AT THE BEGINNING works supreme success,
                Furthering through perseverance.
                Nothing should be undertaken.
                It furthers one to appoint helpers.
                """,
            image: """
                Clouds and thunder:
                The image of DIFFICULTY AT THE BEGINNING.
                Thus the superior man
                Brings order out of confusion.
                """,
            commentary: """
                The name of the hexagram means a blade of grass pushing against an obstacle as it sprouts out of the earth—hence the meaning: difficulty at the beginning. The hexagram shows a birth coming out of chaos. Thunder and rain fill the air. But the chaos clears up. While the thunderstorm brings release from tension, everything is still in disorder. This picture symbolizes the initial difficulties that confront a great undertaking.
                
                Times of growth are beset with difficulties. They resemble a first birth. But these difficulties arise from the profusion of all that is struggling to attain form. Everything is in motion; therefore, if one perseveres, there is a prospect of great success.
                """,
            lineTexts: [
                LineMeaning(position: 1, text: "Hesitation and hindrance. It furthers one to remain persevering. It furthers one to appoint helpers.", interpretation: "At the beginning of an enterprise, obstacles and resistance are natural. Rather than forcing matters, remain steadfast and gather support."),
                LineMeaning(position: 2, text: "Difficulties pile up. Horse and wagon part. He is not a robber; he will woo at the right time. The maiden is chaste; she does not pledge herself. Ten years—then she pledges herself.", interpretation: "Difficulties and complications arise, but a helper appears who seems like an adversary at first. Trust takes time to develop; patience is essential."),
                LineMeaning(position: 3, text: "Whoever hunts deer without the forester only loses his way in the forest. The superior man understands the signs of the time and prefers to desist. To go on brings humiliation.", interpretation: "Without proper guidance, pursuing goals leads only to confusion. Recognize when expert help is needed, and don't pursue goals blindly out of pride."),
                LineMeaning(position: 4, text: "Horse and wagon part. Strive for union. To go brings good fortune. Everything acts to further.", interpretation: "Though separation threatens, actively seeking union with those who can help leads to success. This is the time to move forward."),
                LineMeaning(position: 5, text: "Difficulties in blessing. A little perseverance brings good fortune. Great perseverance brings misfortune.", interpretation: "When in a position of responsibility during difficult times, proceed cautiously with small steps. Trying to do too much leads to failure."),
                LineMeaning(position: 6, text: "Horse and wagon part. Bloody tears flow.", interpretation: "The time is not right for the enterprise; difficulties have become overwhelming. Accept the situation and wait for better conditions.")
            ]
        )
    }
    
    func createHexagram4() -> Hexagram {
        Hexagram(
            id: 4,
            chineseName: "蒙",
            pinyin: "méng",
            englishName: "Youthful Folly",
            character: "䷃",
            upperTrigram: .mountain,
            lowerTrigram: .water,
            judgment: """
                YOUTHFUL FOLLY has success.
                It is not I who seek the young fool;
                The young fool seeks me.
                At the first oracle I inform him.
                If he asks two or three times, it is importunity.
                If he importunes, I give him no information.
                Perseverance furthers.
                """,
            image: """
                A spring wells up at the foot of the mountain:
                The image of YOUTH.
                Thus the superior man fosters his character
                By thoroughness in all that he does.
                """,
            commentary: """
                In this hexagram we are reminded of youth and folly in two different ways. The image of the upper trigram, Kěn, is the mountain; that of the lower, K'an, is water; the spring rising at the foot of the mountain is the image of inexperienced youth.
                
                Keeping still is the attribute of the upper trigram; that of the lower is the abyss, danger. Stopping in perplexity on the brink of a dangerous abyss is a symbol of the folly of youth. However, the two trigrams also show the way of overcoming the follies of youth: water is something that necessarily flows on; when the spring gushes forth, it does not know at first where it will go. But its steady flow fills up the deep place blocking its progress, and success is attained.
                """,
            lineTexts: [
                LineMeaning(position: 1, text: "To make a fool develop, it furthers one to apply discipline. The fetters should be removed. To go on in this way brings humiliation.", interpretation: "Beginning instruction requires discipline, but it should not become oppressive. Once the lesson is learned, restrictions should be relaxed."),
                LineMeaning(position: 2, text: "To bear with fools in kindness brings good fortune. To know how to take women brings good fortune. The son is capable of taking charge of the household.", interpretation: "Those with responsibility should treat the inexperienced with tolerance and understanding while maintaining proper boundaries."),
                LineMeaning(position: 3, text: "Take not a maiden who, when she sees a man of bronze, loses possession of herself. Nothing furthers.", interpretation: "One who abandons principles for superficial attractions shows a lack of character. Guard against being swept away by appearances."),
                LineMeaning(position: 4, text: "Entangled folly brings humiliation.", interpretation: "When one is too stubborn to accept guidance and too proud to learn, humiliation results. Empty fantasies lead nowhere."),
                LineMeaning(position: 5, text: "Childlike folly brings good fortune.", interpretation: "An open, humble attitude that genuinely seeks to learn leads to good fortune. True wisdom comes from accepting one's ignorance."),
                LineMeaning(position: 6, text: "In punishing folly, it does not further one to commit transgressions. The only thing that furthers is to prevent transgressions.", interpretation: "Discipline should serve to prevent wrongdoing, not merely to punish it. Education aims to develop character, not inflict suffering.")
            ]
        )
    }
    
    func createHexagram5() -> Hexagram {
        Hexagram(
            id: 5,
            chineseName: "需",
            pinyin: "xū",
            englishName: "Waiting (Nourishment)",
            character: "䷄",
            upperTrigram: .water,
            lowerTrigram: .heaven,
            judgment: """
                WAITING. If you are sincere,
                You have light and success.
                Perseverance brings good fortune.
                It furthers one to cross the great water.
                """,
            image: """
                Clouds rise up to heaven:
                The image of WAITING.
                Thus the superior man eats and drinks,
                Is joyous and of good cheer.
                """,
            commentary: """
                All beings have need of nourishment from above. But the gift of food comes in its own time, and for this one must wait. This hexagram shows the clouds in the heavens, giving rain to refresh all that grows and to provide mankind with food and drink. The rain will come in its own time. We cannot make it come; we have to wait for it.
                
                The idea of waiting is further suggested by the trigrams: strength within, danger ahead. Strength in the face of danger does not plunge ahead but bides its time, whereas weakness in the face of danger grows agitated and has not the patience to wait.
                """,
            lineTexts: [
                LineMeaning(position: 1, text: "Waiting in the meadow. It furthers one to abide in what endures. No blame.", interpretation: "The danger is still far away. One waits in peace and maintains regular activities. Don't exhaust yourself with worry about distant threats."),
                LineMeaning(position: 2, text: "Waiting on the sand. There is some gossip. The end brings good fortune.", interpretation: "Danger approaches. Unrest grows but has not yet become threatening. Minor difficulties and criticism arise, but maintaining composure leads to a good outcome."),
                LineMeaning(position: 3, text: "Waiting in the mud brings about the arrival of the enemy.", interpretation: "One has advanced too close to danger. By acting prematurely, one becomes vulnerable. Serious caution is needed to avoid disaster."),
                LineMeaning(position: 4, text: "Waiting in blood. Get out of the pit.", interpretation: "The situation is extremely dangerous. One must simply endure and find a way out of the immediate threat. Action may be required despite the risk."),
                LineMeaning(position: 5, text: "Waiting at meat and drink. Perseverance brings good fortune.", interpretation: "Even in the midst of danger, there comes a pause. Use this respite to gather strength. Enjoy the moment but remain alert."),
                LineMeaning(position: 6, text: "One falls into the pit. Three uninvited guests arrive. Honor them, and in the end there will be good fortune.", interpretation: "The wait is over; fate intervenes. Accept unexpected developments gracefully. What seems unfortunate may bring salvation if received properly.")
            ]
        )
    }
    
    func createHexagram6() -> Hexagram {
        Hexagram(
            id: 6,
            chineseName: "訟",
            pinyin: "sòng",
            englishName: "Conflict",
            character: "䷅",
            upperTrigram: .heaven,
            lowerTrigram: .water,
            judgment: """
                CONFLICT. You are sincere
                And are being obstructed.
                A cautious halt halfway brings good fortune.
                Going through to the end brings misfortune.
                It furthers one to see the great man.
                It does not further one to cross the great water.
                """,
            image: """
                Heaven and water go their opposite ways:
                The image of CONFLICT.
                Thus in all his transactions the superior man
                Carefully considers the beginning.
                """,
            commentary: """
                The upper trigram, whose image is heaven, has an upward movement; the lower trigram, water, in accordance with its nature, tends downward. Thus the two halves move away from each other, giving rise to the idea of conflict. The attribute of the Creative is strength, that of the Abysmal is danger, cunning. Where cunning has force before it, there is conflict.
                
                A second indication of conflict is seen in the combination of deep cunning within and fixed determination outwardly. A person of this character will certainly be quarrelsome.
                """,
            lineTexts: [
                LineMeaning(position: 1, text: "If one does not perpetuate the affair, there is a little gossip. In the end, good fortune comes.", interpretation: "When conflict arises, drop the matter quickly rather than prolonging the dispute. There may be minor criticism, but the outcome will be favorable."),
                LineMeaning(position: 2, text: "One cannot engage in conflict; one returns home, gives way. The people of his town, three hundred households, remain free of guilt.", interpretation: "When outmatched in a conflict, retreat is the wiser course. This protects not just oneself but those who depend on you."),
                LineMeaning(position: 3, text: "To nourish oneself on ancient virtue induces perseverance. Danger. In the end, good fortune comes. If by chance you are in the service of a king, seek not works.", interpretation: "Draw strength from enduring values during conflict. Don't seek recognition; quietly persevere and eventually good fortune comes."),
                LineMeaning(position: 4, text: "One cannot engage in conflict. One turns back and submits to fate, changes one's attitude, and finds peace in perseverance. Good fortune.", interpretation: "Accepting that one cannot win, one changes course. This acceptance of reality brings inner peace and good fortune."),
                LineMeaning(position: 5, text: "To contend before him brings supreme good fortune.", interpretation: "When a just arbiter can be found, submitting the conflict for judgment leads to a favorable resolution. Seek fair mediation."),
                LineMeaning(position: 6, text: "Even if by chance a leather belt is bestowed on one, by the end of a morning it will have been snatched away three times.", interpretation: "Even if you win the conflict, the victory will not last. Gains won through contention are unstable and easily lost.")
            ]
        )
    }
    
    func createHexagram7() -> Hexagram {
        Hexagram(
            id: 7,
            chineseName: "師",
            pinyin: "shī",
            englishName: "The Army",
            character: "䷆",
            upperTrigram: .earth,
            lowerTrigram: .water,
            judgment: """
                THE ARMY. The army needs perseverance
                And a strong man.
                Good fortune without blame.
                """,
            image: """
                In the middle of the earth is water:
                The image of THE ARMY.
                Thus the superior man increases his masses
                By generosity toward the people.
                """,
            commentary: """
                This hexagram is made up of the trigrams K'an, water, and K'un, earth, and thus it symbolizes the ground water stored up in the earth. In the same way military strength is stored up in the mass of the people—invisible in times of peace but always ready for use as a source of power.
                
                The attributes of the two trigrams are danger inside and obedience outside. This points to the nature of an army, which at the core is dangerous while outwardly it displays discipline and obedience.
                """,
            lineTexts: [
                LineMeaning(position: 1, text: "An army must set forth in proper order. If the order is not good, misfortune threatens.", interpretation: "Success requires proper organization from the start. Without clear structure and discipline, any collective endeavor will fail."),
                LineMeaning(position: 2, text: "In the midst of the army. Good fortune. No blame. The king bestows a triple decoration.", interpretation: "The leader is at the center of action, sharing hardships with followers. Such leadership earns recognition and success."),
                LineMeaning(position: 3, text: "Perchance the army carries corpses in the wagon. Misfortune.", interpretation: "When unqualified people assume command, disaster follows. Too many leaders or wrong leadership leads to defeat."),
                LineMeaning(position: 4, text: "The army retreats. No blame.", interpretation: "Knowing when to retreat is as important as knowing when to advance. Strategic withdrawal in the face of superior force is wise."),
                LineMeaning(position: 5, text: "There is game in the field. It furthers one to catch it. Without blame. Let the eldest lead the army. The younger transports corpses; then perseverance brings misfortune.", interpretation: "When dealing with wrongdoing, act decisively but appoint experienced leaders. Inexperienced commanders bring disaster."),
                LineMeaning(position: 6, text: "The great prince issues commands, founds states, vests families with fiefs. Inferior people should not be employed.", interpretation: "After victory, rewards are distributed. However, those who helped achieve success through questionable means should not be given lasting positions of power.")
            ]
        )
    }
    
    func createHexagram8() -> Hexagram {
        Hexagram(
            id: 8,
            chineseName: "比",
            pinyin: "bǐ",
            englishName: "Holding Together (Union)",
            character: "䷇",
            upperTrigram: .water,
            lowerTrigram: .earth,
            judgment: """
                HOLDING TOGETHER brings good fortune.
                Inquire of the oracle once again
                Whether you possess sublimity, constancy, and perseverance;
                Then there is no blame.
                Those who are uncertain gradually join.
                Whoever comes too late
                Meets with misfortune.
                """,
            image: """
                On the earth is water:
                The image of HOLDING TOGETHER.
                Thus the kings of antiquity
                Bestowed the different states as fiefs
                And cultivated friendly relations with the feudal lords.
                """,
            commentary: """
                Water fills up all the empty places on the earth and clings fast to it. The social organization of ancient China was based on this principle of holding together: water over earth, dependence complemented by support.
                
                What is required is that we unite with others, in order that all may complement and aid one another through holding together. But such holding together calls for a central figure around whom other persons may unite. To become a center of influence holding people together is a grave matter and fraught with great responsibility.
                """,
            lineTexts: [
                LineMeaning(position: 1, text: "Hold to him in truth and loyalty; this is without blame. Truth, like a full earthen bowl: thus in the end good fortune comes from without.", interpretation: "Union must be based on sincerity and truth. Inner genuineness naturally attracts others and brings good fortune."),
                LineMeaning(position: 2, text: "Hold to him inwardly. Perseverance brings good fortune.", interpretation: "Maintain connection with what is right through inner devotion, not merely external compliance. This inner loyalty leads to good fortune."),
                LineMeaning(position: 3, text: "You hold together with the wrong people.", interpretation: "Association with the wrong people is dangerous. Examine your connections and be careful about the company you keep."),
                LineMeaning(position: 4, text: "Hold to him outwardly also. Perseverance brings good fortune.", interpretation: "Inner loyalty should also manifest outwardly. Open expression of one's allegiance is appropriate and brings good fortune."),
                LineMeaning(position: 5, text: "Manifestation of holding together. In the hunt the king uses beaters on three sides only and forgoes game that runs off in front. The citizens need no warning. Good fortune.", interpretation: "Leadership should be based on mutual respect, not force. Allow people to come freely rather than coercing them."),
                LineMeaning(position: 6, text: "He finds no head for holding together. Misfortune.", interpretation: "When union lacks a proper beginning or leader, it cannot succeed. Relationships formed without proper foundation fail.")
            ]
        )
    }
    
    func createHexagram9() -> Hexagram {
        Hexagram(
            id: 9,
            chineseName: "小畜",
            pinyin: "xiǎo xù",
            englishName: "The Taming Power of the Small",
            character: "䷈",
            upperTrigram: .wind,
            lowerTrigram: .heaven,
            judgment: """
                THE TAMING POWER OF THE SMALL
                Has success.
                Dense clouds, no rain from our western region.
                """,
            image: """
                The wind drives across heaven:
                The image of THE TAMING POWER OF THE SMALL.
                Thus the superior man
                Refines the outward aspect of his nature.
                """,
            commentary: """
                This hexagram means the force of the small—the power of the yielding—that restrains, tames, and impedes. In the fourth place, that of the minister, is a yielding line that holds together the five strong lines. In the Image it is the wind blowing across the sky.
                
                The wind can indeed drive the clouds together in the sky; yet, being nothing but air without solid body, it does not produce great or lasting effects. So also an individual, in times when they cannot carry out their plans, can still work through small means on the refinement of their nature.
                """,
            lineTexts: [
                LineMeaning(position: 1, text: "Return to the way. How could there be blame in this? Good fortune.", interpretation: "When blocked, return to your fundamental path. There is no shame in not being able to advance; maintaining integrity brings good fortune."),
                LineMeaning(position: 2, text: "He allows himself to be drawn into returning. Good fortune.", interpretation: "Rather than forcing forward, allow yourself to be influenced to return to the right way. This receptivity brings good fortune."),
                LineMeaning(position: 3, text: "The spokes burst out of the wagon wheels. Man and wife roll their eyes.", interpretation: "Pressing forward despite obstacles leads to breakdown. Relationships suffer when one insists on proceeding at the wrong time."),
                LineMeaning(position: 4, text: "If you are sincere, blood vanishes and fear gives way. No blame.", interpretation: "Sincerity and truth dispel danger and fear. When you act from genuine conviction, obstacles dissolve."),
                LineMeaning(position: 5, text: "If you are sincere and loyally attached, you are rich in your neighbor.", interpretation: "True partnership is based on mutual trust and loyalty. Such bonds create shared prosperity."),
                LineMeaning(position: 6, text: "The rain comes, there is rest. This is due to the lasting effect of character. Perseverance brings the woman into danger. The moon is nearly full. If the superior man persists, misfortune comes.", interpretation: "The restrained force finally achieves its goal. But this is not the time to press for more; know when to stop at the moment of success.")
            ]
        )
    }
    
    func createHexagram10() -> Hexagram {
        Hexagram(
            id: 10,
            chineseName: "履",
            pinyin: "lǚ",
            englishName: "Treading (Conduct)",
            character: "䷉",
            upperTrigram: .heaven,
            lowerTrigram: .lake,
            judgment: """
                TREADING. Treading upon the tail of the tiger.
                It does not bite the man. Success.
                """,
            image: """
                Heaven above, the lake below:
                The image of TREADING.
                Thus the superior man discriminates between high and low,
                And thereby fortifies the thinking of the people.
                """,
            commentary: """
                The upper trigram means heaven, the lower, a body of water. The difference between the two gives the idea of treading on something. Heaven is the father, the lake is the youngest daughter; hence the hexagram also suggests the relationship between father and daughter, the strong and the weak.
                
                The situation is perilous. The position requires one to tread on the tail of a tiger, which could bite. But if one knows the right way to behave, one can avoid danger. Proper conduct, maintained with innocent cheerfulness, brings success even in dangerous circumstances.
                """,
            lineTexts: [
                LineMeaning(position: 1, text: "Simple conduct. Progress without blame.", interpretation: "Proceeding simply and sincerely, without pretension, allows safe progress. Stay true to your nature without seeking recognition."),
                LineMeaning(position: 2, text: "Treading a smooth, level course. The perseverance of a dark man brings good fortune.", interpretation: "One who remains quiet and independent, not seeking engagement with the world, finds a peaceful path. Contentment in simplicity."),
                LineMeaning(position: 3, text: "A one-eyed man is able to see, a lame man is able to tread. He treads on the tail of the tiger. The tiger bites the man. Misfortune. Thus does a warrior act on behalf of his great prince.", interpretation: "One who overestimates their abilities and acts rashly encounters danger. Only in service to a great cause might such rashness be appropriate."),
                LineMeaning(position: 4, text: "He treads on the tail of the tiger. Caution and circumspection lead ultimately to good fortune.", interpretation: "The situation is dangerous but manageable through extreme caution. Awareness of risk and careful action bring eventual success."),
                LineMeaning(position: 5, text: "Resolute conduct. Perseverance with awareness of danger.", interpretation: "One must act decisively while remaining fully aware of the risks involved. Resolution combined with caution is needed."),
                LineMeaning(position: 6, text: "Look to your conduct and weigh the favorable signs. When everything is fulfilled, supreme good fortune comes.", interpretation: "Review your actions and their results. When conduct has been correct and circumstances align, great good fortune follows.")
            ]
        )
    }
    
    func createHexagram11() -> Hexagram {
        Hexagram(
            id: 11,
            chineseName: "泰",
            pinyin: "tài",
            englishName: "Peace",
            character: "䷊",
            upperTrigram: .earth,
            lowerTrigram: .heaven,
            judgment: """
                PEACE. The small departs,
                The great approaches.
                Good fortune. Success.
                """,
            image: """
                Heaven and earth unite:
                The image of PEACE.
                Thus the ruler
                Divides and completes the course of heaven and earth;
                He furthers and regulates the gifts of heaven and earth,
                And so aids the people.
                """,
            commentary: """
                This hexagram denotes a time in nature when heaven seems to be on earth. Heaven has placed itself beneath the earth, and so their powers unite in deep harmony. Then peace and blessing descend upon all living things.
                
                In the world of man it is a time of social harmony; those in high places show favor to the lowly, and the lowly and inferior in their turn are well disposed toward the highly placed. There is an end to all feuds. The inward disposition of the two corresponds; the strong and light receive the weak and dark inside them.
                """,
            lineTexts: [
                LineMeaning(position: 1, text: "When ribbon grass is pulled up, the sod comes with it. Each according to his kind. Undertakings bring good fortune.", interpretation: "In times of prosperity, like-minded people naturally come together. This is the time for new undertakings—they will be successful."),
                LineMeaning(position: 2, text: "Bearing with the uncultured in gentleness, fording the river with resolution, not neglecting what is distant, not regarding one's companions: thus one may manage to walk in the middle.", interpretation: "True leadership in peaceful times requires tolerance, determination, broad vision, and impartiality. Maintain the middle way."),
                LineMeaning(position: 3, text: "No plain not followed by a slope. No going not followed by a return. He who remains persevering in danger is without blame. Do not complain about this truth; enjoy the good fortune you still possess.", interpretation: "Every peak is followed by a valley; every advance by a retreat. Accept these cycles and enjoy prosperity while it lasts."),
                LineMeaning(position: 4, text: "He flutters down, not boasting of his wealth, together with his neighbor, guileless and sincere.", interpretation: "Those in high position should associate naturally with those below, without pride or pretension. Genuine simplicity brings harmony."),
                LineMeaning(position: 5, text: "The sovereign I gives his daughter in marriage. This brings blessing and supreme good fortune.", interpretation: "Like a wise ruler who unites with those below through marriage alliance, humble connection with others brings great good fortune."),
                LineMeaning(position: 6, text: "The wall falls back into the moat. Use no army now. Make your commands known within your own town. Perseverance brings humiliation.", interpretation: "The time of peace is ending. Resistance is futile; accept the change gracefully rather than fighting against the inevitable decline.")
            ]
        )
    }
    
    func createHexagram12() -> Hexagram {
        Hexagram(
            id: 12,
            chineseName: "否",
            pinyin: "pǐ",
            englishName: "Standstill (Stagnation)",
            character: "䷋",
            upperTrigram: .heaven,
            lowerTrigram: .earth,
            judgment: """
                STANDSTILL. Evil people do not further
                The perseverance of the superior man.
                The great departs; the small approaches.
                """,
            image: """
                Heaven and earth do not unite:
                The image of STANDSTILL.
                Thus the superior man falls back upon his inner worth
                In order to escape the difficulties.
                He does not permit himself to be honored with revenue.
                """,
            commentary: """
                This hexagram is the opposite of the preceding one. Heaven is above, drawing farther and farther away, while the earth below sinks further into the depths. The creative powers are not in relation. It is a time of standstill and decline.
                
                This hexagram is linked with the seventh month (August-September), when the year has passed its zenith and autumnal decay is setting in. The character of the time is such that inferior people are coming forward and taking control, while superior people withdraw and are not seen.
                """,
            lineTexts: [
                LineMeaning(position: 1, text: "When ribbon grass is pulled up, the sod comes with it. Each according to his kind. Perseverance brings good fortune and success.", interpretation: "In times of decline, those of similar character should withdraw together. Remaining true to one's nature during difficult times leads to eventual success."),
                LineMeaning(position: 2, text: "They bear and endure; this means good fortune for inferior people. The standstill serves to help the great man to attain success.", interpretation: "For lesser people, patient endurance is wise. For the superior person, this time of withdrawal allows inner development that leads to future success."),
                LineMeaning(position: 3, text: "They bear shame.", interpretation: "Those who have assumed power wrongly become aware of their unworthiness. Shame arises from acting beyond one's true capacity."),
                LineMeaning(position: 4, text: "He who acts at the command of the highest remains without blame. Those of like mind partake of the blessing.", interpretation: "When acting from a higher purpose, one avoids blame. Those who share this purpose also benefit."),
                LineMeaning(position: 5, text: "Standstill is giving way. Good fortune for the great man. 'What if it should fail, what if it should fail?' In this way he ties it to a cluster of mulberry shoots.", interpretation: "The stagnation begins to lift for one who maintains vigilance. Success comes by remaining alert and grounded."),
                LineMeaning(position: 6, text: "The standstill comes to an end. First standstill, then good fortune.", interpretation: "Stagnation does not last forever. Through effort and perseverance, the blockage is overcome and good fortune returns.")
            ]
        )
    }
    
    func createHexagram13() -> Hexagram {
        Hexagram(
            id: 13,
            chineseName: "同人",
            pinyin: "tóng rén",
            englishName: "Fellowship with Men",
            character: "䷌",
            upperTrigram: .heaven,
            lowerTrigram: .fire,
            judgment: """
                FELLOWSHIP WITH MEN in the open.
                Success.
                It furthers one to cross the great water.
                The perseverance of the superior man furthers.
                """,
            image: """
                Heaven together with fire:
                The image of FELLOWSHIP WITH MEN.
                Thus the superior man organizes the clans
                And makes distinctions between things.
                """,
            commentary: """
                True fellowship among people must be based upon a concern that is universal. It is not the private interests of the individual that create lasting fellowship among people, but rather the goals of humanity.
                
                The foundation of great unity lies in the nature of the things themselves. Fire by its nature blazes up to heaven, and heaven by nature is above. Thus their natures show affinity. Similarly, fellowship among people must be based upon natural affinity—shared values and common humanity.
                """,
            lineTexts: [
                LineMeaning(position: 1, text: "Fellowship with men at the gate. No blame.", interpretation: "Beginning fellowship openly and without hidden agendas creates the foundation for genuine community. Meet others at the entrance without reservations."),
                LineMeaning(position: 2, text: "Fellowship with men in the clan. Humiliation.", interpretation: "Fellowship limited by faction or special interest is restricting and leads to problems. Avoid cliquishness."),
                LineMeaning(position: 3, text: "He hides weapons in the thicket; he climbs the high hill in front of it. For three years he does not rise.", interpretation: "Mistrust and hidden aggression destroy fellowship. One who harbors secret hostility cannot achieve their aims."),
                LineMeaning(position: 4, text: "He climbs up on his wall; he cannot attack. Good fortune.", interpretation: "Conflict approaches but cannot succeed. The obstacle proves insurmountable, which actually brings good fortune by preventing harmful action."),
                LineMeaning(position: 5, text: "Men bound in fellowship first weep and lament, but afterward they laugh. After great struggles they succeed in meeting.", interpretation: "True fellowship may require overcoming obstacles and initial sorrow. But genuine connection ultimately brings joy."),
                LineMeaning(position: 6, text: "Fellowship with men in the meadow. No remorse.", interpretation: "Fellowship that remains on the surface—cordial but not deeply committed—is acceptable but not ideal. There is no regret, but also no profound connection.")
            ]
        )
    }
    
    func createHexagram14() -> Hexagram {
        Hexagram(
            id: 14,
            chineseName: "大有",
            pinyin: "dà yǒu",
            englishName: "Possession in Great Measure",
            character: "䷍",
            upperTrigram: .fire,
            lowerTrigram: .heaven,
            judgment: """
                POSSESSION IN GREAT MEASURE.
                Supreme success.
                """,
            image: """
                Fire in heaven above:
                The image of POSSESSION IN GREAT MEASURE.
                Thus the superior man curbs evil and furthers good,
                And thereby obeys the benevolent will of heaven.
                """,
            commentary: """
                The fire in heaven above shines far and illuminates all things, so that all things stand out in relief. Here the position of strength is occupied by a yielding element—the single yielding line at the peak. This indicates one who possesses great abundance yet remains modest.
                
                The two trigrams indicate that strength and clarity unite. Possession in great measure is determined by fate and accords with the time. The will of heaven is to further life and the good. One who has received great blessings should use them to promote the good.
                """,
            lineTexts: [
                LineMeaning(position: 1, text: "No relationship with what is harmful; there is no blame in this. If one remains conscious of difficulty, one remains without blame.", interpretation: "In times of abundance, avoid harmful associations. Awareness of potential difficulties helps maintain good fortune."),
                LineMeaning(position: 2, text: "A big wagon for loading. One may undertake something. No blame.", interpretation: "Great resources are available; large undertakings can be carried out. The capacity exists for major accomplishments."),
                LineMeaning(position: 3, text: "A prince offers it to the Son of Heaven. A petty man cannot do this.", interpretation: "Great wealth should be shared with those in higher service. A generous spirit dedicates abundance to worthy causes."),
                LineMeaning(position: 4, text: "He makes a difference between himself and his neighbor. No blame.", interpretation: "One with abundant resources should maintain appropriate distinctions and not become entangled with the greedy. Keeping boundaries brings no blame."),
                LineMeaning(position: 5, text: "He whose truth is accessible, yet dignified, has good fortune.", interpretation: "True authority comes from one who is approachable yet maintains dignity. Sincerity combined with proper bearing brings good fortune."),
                LineMeaning(position: 6, text: "He is blessed by heaven. Good fortune. Nothing that does not further.", interpretation: "Supreme good fortune. Heaven itself supports one who is modest and sincere despite great possession. Everything furthers progress.")
            ]
        )
    }
    
    func createHexagram15() -> Hexagram {
        Hexagram(
            id: 15,
            chineseName: "謙",
            pinyin: "qiān",
            englishName: "Modesty",
            character: "䷎",
            upperTrigram: .earth,
            lowerTrigram: .mountain,
            judgment: """
                MODESTY creates success.
                The superior man carries things through.
                """,
            image: """
                Within the earth, a mountain:
                The image of MODESTY.
                Thus the superior man reduces that which is too much,
                And augments that which is too little.
                He weighs things and makes them equal.
                """,
            commentary: """
                This hexagram is made up of the trigrams Kěn, Keeping Still, mountain, and K'un, the Receptive, earth. The mountain is the youngest son of the Creative, the representative of heaven on earth. It dispenses the blessings of heaven, the clouds and rain that gather round its summit.
                
                This shows what modesty means. A high mountain hidden beneath the earth creates the image of one who has much but remains humble. Modesty consists in keeping oneself in the background.
                """,
            lineTexts: [
                LineMeaning(position: 1, text: "A superior man modest about his modesty may cross the great water. Good fortune.", interpretation: "True humility is not self-conscious. One who is genuinely modest, without making a display of it, can accomplish great things."),
                LineMeaning(position: 2, text: "Modesty that comes to expression. Perseverance brings good fortune.", interpretation: "When inner modesty naturally expresses itself outwardly, it influences others positively. This authentic humility brings lasting good fortune."),
                LineMeaning(position: 3, text: "A superior man of modesty and merit carries things to conclusion. Good fortune.", interpretation: "One who accomplishes great things yet remains modest is truly admirable. Such a person can complete any undertaking successfully."),
                LineMeaning(position: 4, text: "Nothing that would not further modesty in movement.", interpretation: "All actions benefit from being performed with a modest attitude. Modesty should infuse one's entire conduct."),
                LineMeaning(position: 5, text: "No boasting of wealth before one's neighbor. It is favorable to attack with force. Nothing that would not further.", interpretation: "When in a position of authority, remain modest. If action against wrongdoing is necessary, firmness is appropriate, but arrogance is not."),
                LineMeaning(position: 6, text: "Modesty that comes to expression. It is favorable to set armies marching to chastise one's own city and one's country.", interpretation: "True modesty enables one to be self-critical and correct faults in one's own domain. The modest leader addresses problems at home first.")
            ]
        )
    }
    
    func createHexagram16() -> Hexagram {
        Hexagram(
            id: 16,
            chineseName: "豫",
            pinyin: "yù",
            englishName: "Enthusiasm",
            character: "䷏",
            upperTrigram: .thunder,
            lowerTrigram: .earth,
            judgment: """
                ENTHUSIASM. It furthers one to install helpers
                And to set armies marching.
                """,
            image: """
                Thunder comes resounding out of the earth:
                The image of ENTHUSIASM.
                Thus the ancient kings made music
                In order to honor merit,
                And offered it with splendor
                To the Supreme Deity,
                Inviting their ancestors to be present.
                """,
            commentary: """
                The strong fourth line moves up. It finds all other lines yielding—conditions are favorable for it. The fourth line moves upward, and others follow with enthusiasm.
                
                The time is favorable for appointing helpers and setting things in motion. The image of thunder rising from the earth suggests the first stirrings of enthusiastic movement, like the awakening of nature in spring.
                """,
            lineTexts: [
                LineMeaning(position: 1, text: "Enthusiasm that expresses itself brings misfortune.", interpretation: "Displaying enthusiasm before others, especially to curry favor with the powerful, brings misfortune. Premature expression is harmful."),
                LineMeaning(position: 2, text: "Firm as a rock. Not a whole day. Perseverance brings good fortune.", interpretation: "One who recognizes the first signs of decline and does not let a whole day pass before acting is like a rock—firm and perceptive. This brings good fortune."),
                LineMeaning(position: 3, text: "Enthusiasm that looks upward creates remorse. Hesitation brings remorse.", interpretation: "Looking to others to generate one's enthusiasm leads to regret. But hesitating too long also causes problems. Find the right moment to act."),
                LineMeaning(position: 4, text: "The source of enthusiasm. He achieves great things. Doubt not. You gather friends around you as a hair clasp gathers the hair.", interpretation: "The leader who inspires enthusiasm gathers supporters naturally. Confidence in one's purpose draws others together."),
                LineMeaning(position: 5, text: "Persistently ill, and still does not die.", interpretation: "Pressure and opposition are constant, but one endures. Though unable to express enthusiasm freely, one survives through persistence."),
                LineMeaning(position: 6, text: "Deluded enthusiasm. But if after completion one changes, there is no blame.", interpretation: "Enthusiasm based on illusion cannot last. But if one awakens and changes course once the error becomes clear, blame is avoided.")
            ]
        )
    }
}
