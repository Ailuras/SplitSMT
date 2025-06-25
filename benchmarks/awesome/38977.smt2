(set-option :produce-unsat-cores true) ; enable generation of unsat cores
(set-option :produce-models true) ; enable model generation
(set-logic ALL)

(define-fun get_split_length ((x String) (d String) (limit Int)) Int
  (ite
    (> limit 0)
    (ite (< (str.num_splits x d) limit)
         (str.num_splits x d)
         limit)
    (str.num_splits x d)
  )
)

(define-fun get_split_element ((x String) (d String) (limit Int) (i Int)) String
  (ite
    (and (> limit 0)
         (= i (- limit 1))
         (>= (str.num_splits x d) limit))
    (str.split_rest x d (- limit 1))
    (str.split_at x d i)
  )
)

(declare-sort var3438 0)
(declare-sort var3162 0)
(declare-sort var1208 0)
(declare-sort var1010 0)
(declare-sort var1487 0)
(declare-sort var3987 0)
(declare-sort var816 0)
(declare-sort var1690 0)
(declare-sort var1837 0)
(declare-sort var3278 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun <init>/-279557996 (var3162) void)
(declare-fun cast-from-var3438-to-var3162 (var3438) var3162)
(declare-fun var1208_compile/2141929305 (String) var1208)
(declare-fun utf8ArabicChart/-1809843241 (var3438) var1208)
(declare-fun bwAlefChar/-1809843241 (var3438) String)
(declare-fun bwDiacritics/-1809843241 (var3438) var1208)
(declare-fun bwTatweel/-1809843241 (var3438) var1208)
(declare-fun bwAlef/-1809843241 (var3438) var1208)
(declare-fun bwQuran/-1809843241 (var3438) var1208)
(declare-fun bwNullAnaphoraMarker/-1809843241 (var3438) var1208)
(declare-fun latinPunc/-1809843241 (var3438) var1208)
(declare-fun arabicPunc/-1809843241 (var3438) var1208)
(declare-fun arabicDigit/-1809843241 (var3438) var1208)
(declare-fun utf8Diacritics/-1809843241 (var3438) var1208)
(declare-fun utf8Tatweel/-1809843241 (var3438) var1208)
(declare-fun utf8Alef/-1809843241 (var3438) var1208)
(declare-fun utf8Quran/-1809843241 (var3438) var1208)
(declare-fun utf8ProDrop/-1809843241 (var3438) var1208)
(declare-fun segmentationMarker/-1809843241 (var3438) var1208)
(declare-fun morphemeBoundary/-1809843241 (var3438) var1208)
(declare-fun hasDigit/-1809843241 (var3438) var1208)
(declare-fun useATBVocalizedSectionMapping/-1809843241 (var3438) Bool)
(declare-fun stripMorphemeMarkersInUTF8/-1809843241 (var3438) Bool)
(declare-fun stripSegmentationMarkersInUTF8/-1809843241 (var3438) Bool)
(declare-fun parentTagString/-1809843241 (var3438) String)
(declare-fun utf8CliticString/-1809843241 (var3438) String)
(declare-fun var1487_asList/1779083644 ((Array Int var3162)) var1010)
(declare-fun cast-from-__Array__Int__String__-to-__Array__Int__var3162__ ((Array Int String)) (Array Int var3162))
(declare-fun var816_newHashSet/-438716120 (var1690) var3987)
(declare-fun cast-from-var1010-to-var1690 (var1010) var1690)
(declare-fun var1837_unmodifiableSet/219896279 (var3987) var3987)
(declare-fun parentTagsToEscape/-1809843241 (var3438) var3987)
(declare-fun var3278-init () var3278)
(declare-fun <init>/310296414 (var3278 Bool) void)
(declare-fun apply/-123662758 (var3278 String) String)
(declare-fun bwClitics/-1809843241 (var3438) var3987)
(declare-const null-var3438 var3438)
(declare-const var2982 var3438) ; Statement: r0 := @this: edu.stanford.nlp.international.arabic.pipeline.DefaultLexicalMapper 
(assert (not (= var2982 null-var3438)))
(assert true)
;(assert (<init>/-279557996 (cast-from-var3438-to-var3162 var2982))) ; Statement: specialinvoke r0.<java.lang.Object: void <init>()>() 

(declare-const var2982!1 var3438)
(define-const var1770 var1208 (var1208_compile/2141929305 "[\u0600-\u06ff]")) ; Statement: $r1 = staticinvoke <java.util.regex.Pattern: java.util.regex.Pattern compile(java.lang.String)>("[\u0600-\u06ff]") 
(declare-const var2982!2 var3438)
(assert (not (= var2982!2 null-var3438)))
(assert (= (utf8ArabicChart/-1809843241 var2982!2) var1770)) ; Statement: r0.<edu.stanford.nlp.international.arabic.pipeline.DefaultLexicalMapper: java.util.regex.Pattern utf8ArabicChart> = $r1 
(declare-const var2982!3 var3438)
(assert (not (= var2982!3 null-var3438)))
(assert (= (bwAlefChar/-1809843241 var2982!3) "A")) ; Statement: r0.<edu.stanford.nlp.international.arabic.pipeline.DefaultLexicalMapper: java.lang.String bwAlefChar> = "A" 
(define-const var845 var1208 (var1208_compile/2141929305 "F|N|K|a|u|i|\u005c~|o")) ; Statement: $r2 = staticinvoke <java.util.regex.Pattern: java.util.regex.Pattern compile(java.lang.String)>("F|N|K|a|u|i|\\~|o") 
(declare-const var2982!4 var3438)
(assert (not (= var2982!4 null-var3438)))
(assert (= (bwDiacritics/-1809843241 var2982!4) var845)) ; Statement: r0.<edu.stanford.nlp.international.arabic.pipeline.DefaultLexicalMapper: java.util.regex.Pattern bwDiacritics> = $r2 
(define-const var2379 var1208 (var1208_compile/2141929305 "_")) ; Statement: $r3 = staticinvoke <java.util.regex.Pattern: java.util.regex.Pattern compile(java.lang.String)>("_") 
(declare-const var2982!5 var3438)
(assert (not (= var2982!5 null-var3438)))
(assert (= (bwTatweel/-1809843241 var2982!5) var2379)) ; Statement: r0.<edu.stanford.nlp.international.arabic.pipeline.DefaultLexicalMapper: java.util.regex.Pattern bwTatweel> = $r3 
(define-const var618 var1208 (var1208_compile/2141929305 "\u005c{|\u005c||>|<")) ; Statement: $r4 = staticinvoke <java.util.regex.Pattern: java.util.regex.Pattern compile(java.lang.String)>("\\{|\\||>|<") 
(declare-const var2982!6 var3438)
(assert (not (= var2982!6 null-var3438)))
(assert (= (bwAlef/-1809843241 var2982!6) var618)) ; Statement: r0.<edu.stanford.nlp.international.arabic.pipeline.DefaultLexicalMapper: java.util.regex.Pattern bwAlef> = $r4 
(define-const var1812 var1208 (var1208_compile/2141929305 "`")) ; Statement: $r5 = staticinvoke <java.util.regex.Pattern: java.util.regex.Pattern compile(java.lang.String)>("`") 
(declare-const var2982!7 var3438)
(assert (not (= var2982!7 null-var3438)))
(assert (= (bwQuran/-1809843241 var2982!7) var1812)) ; Statement: r0.<edu.stanford.nlp.international.arabic.pipeline.DefaultLexicalMapper: java.util.regex.Pattern bwQuran> = $r5 
(define-const var2775 var1208 (var1208_compile/2141929305 "\u005c[nll\u005c]")) ; Statement: $r6 = staticinvoke <java.util.regex.Pattern: java.util.regex.Pattern compile(java.lang.String)>("\\[nll\\]") 
(declare-const var2982!8 var3438)
(assert (not (= var2982!8 null-var3438)))
(assert (= (bwNullAnaphoraMarker/-1809843241 var2982!8) var2775)) ; Statement: r0.<edu.stanford.nlp.international.arabic.pipeline.DefaultLexicalMapper: java.util.regex.Pattern bwNullAnaphoraMarker> = $r6 
(define-const var2270 var1208 (var1208_compile/2141929305 "([!-/:-@\u005cu005B-`{-~\u00a1-\u00bf\u00f7\u2010-\u2027\u2030-\u205e\u20a0-\u20ba])+")) ; Statement: $r7 = staticinvoke <java.util.regex.Pattern: java.util.regex.Pattern compile(java.lang.String)>("([!-/:-@\\u005B-`{-~\u00a1-\u00bf\u00f7\u2010-\u2027\u2030-\u205e\u20a0-\u20ba])+") 
(declare-const var2982!9 var3438)
(assert (not (= var2982!9 null-var3438)))
(assert (= (latinPunc/-1809843241 var2982!9) var2270)) ; Statement: r0.<edu.stanford.nlp.international.arabic.pipeline.DefaultLexicalMapper: java.util.regex.Pattern latinPunc> = $r7 
(define-const var1077 var1208 (var1208_compile/2141929305 "([\u00ab\u00bb\u0609-\u060d\u061b-\u061f\u066a\u066c-\u066d\u06d4])+")) ; Statement: $r8 = staticinvoke <java.util.regex.Pattern: java.util.regex.Pattern compile(java.lang.String)>("([\u00ab\u00bb\u0609-\u060d\u061b-\u061f\u066a\u066c-\u066d\u06d4])+") 
(declare-const var2982!10 var3438)
(assert (not (= var2982!10 null-var3438)))
(assert (= (arabicPunc/-1809843241 var2982!10) var1077)) ; Statement: r0.<edu.stanford.nlp.international.arabic.pipeline.DefaultLexicalMapper: java.util.regex.Pattern arabicPunc> = $r8 
(define-const var1132 var1208 (var1208_compile/2141929305 "([\u06f0-\u06f9\u0660-\u0669])+")) ; Statement: $r9 = staticinvoke <java.util.regex.Pattern: java.util.regex.Pattern compile(java.lang.String)>("([\u06f0-\u06f9\u0660-\u0669])+") 
(declare-const var2982!11 var3438)
(assert (not (= var2982!11 null-var3438)))
(assert (= (arabicDigit/-1809843241 var2982!11) var1132)) ; Statement: r0.<edu.stanford.nlp.international.arabic.pipeline.DefaultLexicalMapper: java.util.regex.Pattern arabicDigit> = $r9 
(define-const var2876 var1208 (var1208_compile/2141929305 "\u064e|\u064b|\u064f|\u064c|\u0650|\u064d|\u0651|\u0652|\u0670")) ; Statement: $r10 = staticinvoke <java.util.regex.Pattern: java.util.regex.Pattern compile(java.lang.String)>("\u064e|\u064b|\u064f|\u064c|\u0650|\u064d|\u0651|\u0652|\u0670") 
(declare-const var2982!12 var3438)
(assert (not (= var2982!12 null-var3438)))
(assert (= (utf8Diacritics/-1809843241 var2982!12) var2876)) ; Statement: r0.<edu.stanford.nlp.international.arabic.pipeline.DefaultLexicalMapper: java.util.regex.Pattern utf8Diacritics> = $r10 
(define-const var692 var1208 (var1208_compile/2141929305 "\u0640")) ; Statement: $r11 = staticinvoke <java.util.regex.Pattern: java.util.regex.Pattern compile(java.lang.String)>("\u0640") 
(declare-const var2982!13 var3438)
(assert (not (= var2982!13 null-var3438)))
(assert (= (utf8Tatweel/-1809843241 var2982!13) var692)) ; Statement: r0.<edu.stanford.nlp.international.arabic.pipeline.DefaultLexicalMapper: java.util.regex.Pattern utf8Tatweel> = $r11 
(define-const var2774 var1208 (var1208_compile/2141929305 "\u0627|\u0625|\u0623|\u0622|\u0671")) ; Statement: $r12 = staticinvoke <java.util.regex.Pattern: java.util.regex.Pattern compile(java.lang.String)>("\u0627|\u0625|\u0623|\u0622|\u0671") 
(declare-const var2982!14 var3438)
(assert (not (= var2982!14 null-var3438)))
(assert (= (utf8Alef/-1809843241 var2982!14) var2774)) ; Statement: r0.<edu.stanford.nlp.international.arabic.pipeline.DefaultLexicalMapper: java.util.regex.Pattern utf8Alef> = $r12 
(define-const var3300 var1208 (var1208_compile/2141929305 "[\u0615-\u061a\u06d6-\u06e5]")) ; Statement: $r13 = staticinvoke <java.util.regex.Pattern: java.util.regex.Pattern compile(java.lang.String)>("[\u0615-\u061a\u06d6-\u06e5]") 
(declare-const var2982!15 var3438)
(assert (not (= var2982!15 null-var3438)))
(assert (= (utf8Quran/-1809843241 var2982!15) var3300)) ; Statement: r0.<edu.stanford.nlp.international.arabic.pipeline.DefaultLexicalMapper: java.util.regex.Pattern utf8Quran> = $r13 
(define-const var3492 var1208 (var1208_compile/2141929305 "\u005c[\u0646\u0644\u0644\u005c]")) ; Statement: $r14 = staticinvoke <java.util.regex.Pattern: java.util.regex.Pattern compile(java.lang.String)>("\\[\u0646\u0644\u0644\\]") 
(declare-const var2982!16 var3438)
(assert (not (= var2982!16 null-var3438)))
(assert (= (utf8ProDrop/-1809843241 var2982!16) var3492)) ; Statement: r0.<edu.stanford.nlp.international.arabic.pipeline.DefaultLexicalMapper: java.util.regex.Pattern utf8ProDrop> = $r14 
(define-const var3312 var1208 (var1208_compile/2141929305 "^-+|-+$")) ; Statement: $r15 = staticinvoke <java.util.regex.Pattern: java.util.regex.Pattern compile(java.lang.String)>("^-+|-+$") 
(declare-const var2982!17 var3438)
(assert (not (= var2982!17 null-var3438)))
(assert (= (segmentationMarker/-1809843241 var2982!17) var3312)) ; Statement: r0.<edu.stanford.nlp.international.arabic.pipeline.DefaultLexicalMapper: java.util.regex.Pattern segmentationMarker> = $r15 
(define-const var278 var1208 (var1208_compile/2141929305 "\u005c+")) ; Statement: $r16 = staticinvoke <java.util.regex.Pattern: java.util.regex.Pattern compile(java.lang.String)>("\\+") 
(declare-const var2982!18 var3438)
(assert (not (= var2982!18 null-var3438)))
(assert (= (morphemeBoundary/-1809843241 var2982!18) var278)) ; Statement: r0.<edu.stanford.nlp.international.arabic.pipeline.DefaultLexicalMapper: java.util.regex.Pattern morphemeBoundary> = $r16 
(define-const var520 var1208 (var1208_compile/2141929305 "\u005cd+")) ; Statement: $r17 = staticinvoke <java.util.regex.Pattern: java.util.regex.Pattern compile(java.lang.String)>("\\d+") 
(declare-const var2982!19 var3438)
(assert (not (= var2982!19 null-var3438)))
(assert (= (hasDigit/-1809843241 var2982!19) var520)) ; Statement: r0.<edu.stanford.nlp.international.arabic.pipeline.DefaultLexicalMapper: java.util.regex.Pattern hasDigit> = $r17 
(declare-const var2982!20 var3438)
(assert (not (= var2982!20 null-var3438)))
(assert (= (useATBVocalizedSectionMapping/-1809843241 var2982!20) (ite (= 1 0) true false))) ; Statement: r0.<edu.stanford.nlp.international.arabic.pipeline.DefaultLexicalMapper: boolean useATBVocalizedSectionMapping> = 0 
(declare-const var2982!21 var3438)
(assert (not (= var2982!21 null-var3438)))
(assert (= (stripMorphemeMarkersInUTF8/-1809843241 var2982!21) (ite (= 1 0) true false))) ; Statement: r0.<edu.stanford.nlp.international.arabic.pipeline.DefaultLexicalMapper: boolean stripMorphemeMarkersInUTF8> = 0 
(declare-const var2982!22 var3438)
(assert (not (= var2982!22 null-var3438)))
(assert (= (stripSegmentationMarkersInUTF8/-1809843241 var2982!22) (ite (= 1 0) true false))) ; Statement: r0.<edu.stanford.nlp.international.arabic.pipeline.DefaultLexicalMapper: boolean stripSegmentationMarkersInUTF8> = 0 
(declare-const var2982!23 var3438)
(assert (not (= var2982!23 null-var3438)))
(assert (= (parentTagString/-1809843241 var2982!23) "PUNC LATIN -NONE-")) ; Statement: r0.<edu.stanford.nlp.international.arabic.pipeline.DefaultLexicalMapper: java.lang.String parentTagString> = "PUNC LATIN -NONE-" 
(declare-const var2982!24 var3438)
(assert (not (= var2982!24 null-var3438)))
(assert (= (utf8CliticString/-1809843241 var2982!24) "\u0644 \u0641 \u0648 \u0645\u0627 \u0647 \u0647\u0627 \u0647\u0645 \u0647\u0646 \u0646\u0627 \u0643\u0645 \u062a\u0646 \u062a\u0645 \u0649 \u064a \u0647\u0645\u0627 \u0643 \u0628 \u0645")) ; Statement: r0.<edu.stanford.nlp.international.arabic.pipeline.DefaultLexicalMapper: java.lang.String utf8CliticString> = "\u0644 \u0641 \u0648 \u0645\u0627 \u0647 \u0647\u0627 \u0647\u0645 \u0647\u0646 \u0646\u0627 \u0643\u0645 \u062a\u0646 \u062a\u0645 \u0649 \u064a \u0647\u0645\u0627 \u0643 \u0628 \u0645" 
(define-const var587 String "PUNC LATIN -NONE-") ; Statement: $r18 = "PUNC LATIN -NONE-" 
; split operation: var1241 = var587.split("\u005cs+") ; Statement: $r19 = virtualinvoke $r18.<java.lang.String: java.lang.String[] split(java.lang.String)>("\\s+") 
(define-const var1542 var1010 (var1487_asList/1779083644 (cast-from-__Array__Int__String__-to-__Array__Int__var3162__ var1241))) ; Statement: $r20 = staticinvoke <java.util.Arrays: java.util.List asList(java.lang.Object[])>($r19) 
(define-const var2515 var3987 (var816_newHashSet/-438716120 (cast-from-var1010-to-var1690 var1542))) ; Statement: $r21 = staticinvoke <edu.stanford.nlp.util.Generics: java.util.Set newHashSet(java.util.Collection)>($r20) 
(define-const var3457 var3987 (var1837_unmodifiableSet/219896279 var2515)) ; Statement: $r22 = staticinvoke <java.util.Collections: java.util.Set unmodifiableSet(java.util.Set)>($r21) 
(declare-const var2982!25 var3438)
(assert (not (= var2982!25 null-var3438)))
(assert (= (parentTagsToEscape/-1809843241 var2982!25) var3457)) ; Statement: r0.<edu.stanford.nlp.international.arabic.pipeline.DefaultLexicalMapper: java.util.Set parentTagsToEscape> = $r22 
(define-const var703 var3278 var3278-init) ; Statement: $r23 = new edu.stanford.nlp.international.arabic.Buckwalter 
(assert true)
;(assert (<init>/310296414 var703 (ite (= 1 1) true false))) ; Statement: specialinvoke $r23.<edu.stanford.nlp.international.arabic.Buckwalter: void <init>(boolean)>(1) 

(declare-const var703!1 var3278)
(declare-const var677 Int)
(assert true)
(define-const var117 String (apply/-123662758 var703!1 "\u0644 \u0641 \u0648 \u0645\u0627 \u0647 \u0647\u0627 \u0647\u0645 \u0647\u0646 \u0646\u0627 \u0643\u0645 \u062a\u0646 \u062a\u0645 \u0649 \u064a \u0647\u0645\u0627 \u0643 \u0628 \u0645")) ; Statement: r24 = virtualinvoke $r23.<edu.stanford.nlp.international.arabic.Buckwalter: java.lang.String apply(java.lang.String)>("\u0644 \u0641 \u0648 \u0645\u0627 \u0647 \u0647\u0627 \u0647\u0645 \u0647\u0646 \u0646\u0627 \u0643\u0645 \u062a\u0646 \u062a\u0645 \u0649 \u064a \u0647\u0645\u0627 \u0643 \u0628 \u0645") 
; split operation: var3238 = var117.split("\u005cs+") ; Statement: $r25 = virtualinvoke r24.<java.lang.String: java.lang.String[] split(java.lang.String)>("\\s+") 
(define-const var140 var1010 (var1487_asList/1779083644 (cast-from-__Array__Int__String__-to-__Array__Int__var3162__ var3238))) ; Statement: $r26 = staticinvoke <java.util.Arrays: java.util.List asList(java.lang.Object[])>($r25) 
(define-const var3898 var3987 (var816_newHashSet/-438716120 (cast-from-var1010-to-var1690 var140))) ; Statement: $r27 = staticinvoke <edu.stanford.nlp.util.Generics: java.util.Set newHashSet(java.util.Collection)>($r26) 
(define-const var2943 var3987 (var1837_unmodifiableSet/219896279 var3898)) ; Statement: $r28 = staticinvoke <java.util.Collections: java.util.Set unmodifiableSet(java.util.Set)>($r27) 
(declare-const var2982!26 var3438)
(assert (not (= var2982!26 null-var3438)))
(assert (= (bwClitics/-1809843241 var2982!26) var2943)) ; Statement: r0.<edu.stanford.nlp.international.arabic.pipeline.DefaultLexicalMapper: java.util.Set bwClitics> = $r28 
 ; Statement: return 
(check-sat)
; {<init>/-279557996=([java.lang.Object], void), cast-from-var3438-to-var3162=([edu.stanford.nlp.international.arabic.pipeline.DefaultLexicalMapper], java.lang.Object), var1208_compile/2141929305=([java.lang.String], java.util.regex.Pattern), utf8ArabicChart/-1809843241=([edu.stanford.nlp.international.arabic.pipeline.DefaultLexicalMapper], java.util.regex.Pattern), bwAlefChar/-1809843241=([edu.stanford.nlp.international.arabic.pipeline.DefaultLexicalMapper], java.lang.String), bwDiacritics/-1809843241=([edu.stanford.nlp.international.arabic.pipeline.DefaultLexicalMapper], java.util.regex.Pattern), bwTatweel/-1809843241=([edu.stanford.nlp.international.arabic.pipeline.DefaultLexicalMapper], java.util.regex.Pattern), bwAlef/-1809843241=([edu.stanford.nlp.international.arabic.pipeline.DefaultLexicalMapper], java.util.regex.Pattern), bwQuran/-1809843241=([edu.stanford.nlp.international.arabic.pipeline.DefaultLexicalMapper], java.util.regex.Pattern), bwNullAnaphoraMarker/-1809843241=([edu.stanford.nlp.international.arabic.pipeline.DefaultLexicalMapper], java.util.regex.Pattern), latinPunc/-1809843241=([edu.stanford.nlp.international.arabic.pipeline.DefaultLexicalMapper], java.util.regex.Pattern), arabicPunc/-1809843241=([edu.stanford.nlp.international.arabic.pipeline.DefaultLexicalMapper], java.util.regex.Pattern), arabicDigit/-1809843241=([edu.stanford.nlp.international.arabic.pipeline.DefaultLexicalMapper], java.util.regex.Pattern), utf8Diacritics/-1809843241=([edu.stanford.nlp.international.arabic.pipeline.DefaultLexicalMapper], java.util.regex.Pattern), utf8Tatweel/-1809843241=([edu.stanford.nlp.international.arabic.pipeline.DefaultLexicalMapper], java.util.regex.Pattern), utf8Alef/-1809843241=([edu.stanford.nlp.international.arabic.pipeline.DefaultLexicalMapper], java.util.regex.Pattern), utf8Quran/-1809843241=([edu.stanford.nlp.international.arabic.pipeline.DefaultLexicalMapper], java.util.regex.Pattern), utf8ProDrop/-1809843241=([edu.stanford.nlp.international.arabic.pipeline.DefaultLexicalMapper], java.util.regex.Pattern), segmentationMarker/-1809843241=([edu.stanford.nlp.international.arabic.pipeline.DefaultLexicalMapper], java.util.regex.Pattern), morphemeBoundary/-1809843241=([edu.stanford.nlp.international.arabic.pipeline.DefaultLexicalMapper], java.util.regex.Pattern), hasDigit/-1809843241=([edu.stanford.nlp.international.arabic.pipeline.DefaultLexicalMapper], java.util.regex.Pattern), useATBVocalizedSectionMapping/-1809843241=([edu.stanford.nlp.international.arabic.pipeline.DefaultLexicalMapper], boolean), stripMorphemeMarkersInUTF8/-1809843241=([edu.stanford.nlp.international.arabic.pipeline.DefaultLexicalMapper], boolean), stripSegmentationMarkersInUTF8/-1809843241=([edu.stanford.nlp.international.arabic.pipeline.DefaultLexicalMapper], boolean), parentTagString/-1809843241=([edu.stanford.nlp.international.arabic.pipeline.DefaultLexicalMapper], java.lang.String), utf8CliticString/-1809843241=([edu.stanford.nlp.international.arabic.pipeline.DefaultLexicalMapper], java.lang.String), var1487_asList/1779083644=([java.lang.Object[]], java.util.List), cast-from-__Array__Int__String__-to-__Array__Int__var3162__=([java.lang.String[]], java.lang.Object[]), var816_newHashSet/-438716120=([java.util.Collection], java.util.Set), cast-from-var1010-to-var1690=([java.util.List], java.util.Collection), var1837_unmodifiableSet/219896279=([java.util.Set], java.util.Set), parentTagsToEscape/-1809843241=([edu.stanford.nlp.international.arabic.pipeline.DefaultLexicalMapper], java.util.Set), var3278-init=([], edu.stanford.nlp.international.arabic.Buckwalter), <init>/310296414=([edu.stanford.nlp.international.arabic.Buckwalter, boolean], void), apply/-123662758=([edu.stanford.nlp.international.arabic.Buckwalter, java.lang.String], java.lang.String), bwClitics/-1809843241=([edu.stanford.nlp.international.arabic.pipeline.DefaultLexicalMapper], java.util.Set)}
; {var3438=edu.stanford.nlp.international.arabic.pipeline.DefaultLexicalMapper, var2982=r0, var3162=java.lang.Object, var1208=java.util.regex.Pattern, var1770=$r1, var845=$r2, var2379=$r3, var618=$r4, var1812=$r5, var2775=$r6, var2270=$r7, var1077=$r8, var1132=$r9, var2876=$r10, var692=$r11, var2774=$r12, var3300=$r13, var3492=$r14, var3312=$r15, var278=$r16, var520=$r17, var587=$r18, var1241=$r19, var1010=java.util.List, var1487=java.util.Arrays, var1542=$r20, var3987=java.util.Set, var816=edu.stanford.nlp.util.Generics, var1690=java.util.Collection, var2515=$r21, var1837=java.util.Collections, var3457=$r22, var3278=edu.stanford.nlp.international.arabic.Buckwalter, var703=$r23, var677=1, var117=r24, var3238=$r25, var140=$r26, var3898=$r27, var2943=$r28}
; {edu.stanford.nlp.international.arabic.pipeline.DefaultLexicalMapper=var3438, r0=var2982, java.lang.Object=var3162, java.util.regex.Pattern=var1208, $r1=var1770, $r2=var845, $r3=var2379, $r4=var618, $r5=var1812, $r6=var2775, $r7=var2270, $r8=var1077, $r9=var1132, $r10=var2876, $r11=var692, $r12=var2774, $r13=var3300, $r14=var3492, $r15=var3312, $r16=var278, $r17=var520, $r18=var587, $r19=var1241, java.util.List=var1010, java.util.Arrays=var1487, $r20=var1542, java.util.Set=var3987, edu.stanford.nlp.util.Generics=var816, java.util.Collection=var1690, $r21=var2515, java.util.Collections=var1837, $r22=var3457, edu.stanford.nlp.international.arabic.Buckwalter=var3278, $r23=var703, 1=var677, r24=var117, $r25=var3238, $r26=var140, $r27=var3898, $r28=var2943}
;seq <java.lang.String: java.lang.String[] split(java.lang.String)>;	<java.lang.String: java.lang.String[] split(java.lang.String)>
;cnt {"<java.lang.String: java.lang.String[] split(java.lang.String)>": 2}
;stmts r0 := @this: edu.stanford.nlp.international.arabic.pipeline.DefaultLexicalMapper;	specialinvoke r0.<java.lang.Object: void <init>()>();	$r1 = staticinvoke <java.util.regex.Pattern: java.util.regex.Pattern compile(java.lang.String)>("[\u0600-\u06ff]");	r0.<edu.stanford.nlp.international.arabic.pipeline.DefaultLexicalMapper: java.util.regex.Pattern utf8ArabicChart> = $r1;	r0.<edu.stanford.nlp.international.arabic.pipeline.DefaultLexicalMapper: java.lang.String bwAlefChar> = "A";	$r2 = staticinvoke <java.util.regex.Pattern: java.util.regex.Pattern compile(java.lang.String)>("F|N|K|a|u|i|\\~|o");	r0.<edu.stanford.nlp.international.arabic.pipeline.DefaultLexicalMapper: java.util.regex.Pattern bwDiacritics> = $r2;	$r3 = staticinvoke <java.util.regex.Pattern: java.util.regex.Pattern compile(java.lang.String)>("_");	r0.<edu.stanford.nlp.international.arabic.pipeline.DefaultLexicalMapper: java.util.regex.Pattern bwTatweel> = $r3;	$r4 = staticinvoke <java.util.regex.Pattern: java.util.regex.Pattern compile(java.lang.String)>("\\{|\\||>|<");	r0.<edu.stanford.nlp.international.arabic.pipeline.DefaultLexicalMapper: java.util.regex.Pattern bwAlef> = $r4;	$r5 = staticinvoke <java.util.regex.Pattern: java.util.regex.Pattern compile(java.lang.String)>("`");	r0.<edu.stanford.nlp.international.arabic.pipeline.DefaultLexicalMapper: java.util.regex.Pattern bwQuran> = $r5;	$r6 = staticinvoke <java.util.regex.Pattern: java.util.regex.Pattern compile(java.lang.String)>("\\[nll\\]");	r0.<edu.stanford.nlp.international.arabic.pipeline.DefaultLexicalMapper: java.util.regex.Pattern bwNullAnaphoraMarker> = $r6;	$r7 = staticinvoke <java.util.regex.Pattern: java.util.regex.Pattern compile(java.lang.String)>("([!-/:-@\\u005B-`{-~\u00a1-\u00bf\u00f7\u2010-\u2027\u2030-\u205e\u20a0-\u20ba])+");	r0.<edu.stanford.nlp.international.arabic.pipeline.DefaultLexicalMapper: java.util.regex.Pattern latinPunc> = $r7;	$r8 = staticinvoke <java.util.regex.Pattern: java.util.regex.Pattern compile(java.lang.String)>("([\u00ab\u00bb\u0609-\u060d\u061b-\u061f\u066a\u066c-\u066d\u06d4])+");	r0.<edu.stanford.nlp.international.arabic.pipeline.DefaultLexicalMapper: java.util.regex.Pattern arabicPunc> = $r8;	$r9 = staticinvoke <java.util.regex.Pattern: java.util.regex.Pattern compile(java.lang.String)>("([\u06f0-\u06f9\u0660-\u0669])+");	r0.<edu.stanford.nlp.international.arabic.pipeline.DefaultLexicalMapper: java.util.regex.Pattern arabicDigit> = $r9;	$r10 = staticinvoke <java.util.regex.Pattern: java.util.regex.Pattern compile(java.lang.String)>("\u064e|\u064b|\u064f|\u064c|\u0650|\u064d|\u0651|\u0652|\u0670");	r0.<edu.stanford.nlp.international.arabic.pipeline.DefaultLexicalMapper: java.util.regex.Pattern utf8Diacritics> = $r10;	$r11 = staticinvoke <java.util.regex.Pattern: java.util.regex.Pattern compile(java.lang.String)>("\u0640");	r0.<edu.stanford.nlp.international.arabic.pipeline.DefaultLexicalMapper: java.util.regex.Pattern utf8Tatweel> = $r11;	$r12 = staticinvoke <java.util.regex.Pattern: java.util.regex.Pattern compile(java.lang.String)>("\u0627|\u0625|\u0623|\u0622|\u0671");	r0.<edu.stanford.nlp.international.arabic.pipeline.DefaultLexicalMapper: java.util.regex.Pattern utf8Alef> = $r12;	$r13 = staticinvoke <java.util.regex.Pattern: java.util.regex.Pattern compile(java.lang.String)>("[\u0615-\u061a\u06d6-\u06e5]");	r0.<edu.stanford.nlp.international.arabic.pipeline.DefaultLexicalMapper: java.util.regex.Pattern utf8Quran> = $r13;	$r14 = staticinvoke <java.util.regex.Pattern: java.util.regex.Pattern compile(java.lang.String)>("\\[\u0646\u0644\u0644\\]");	r0.<edu.stanford.nlp.international.arabic.pipeline.DefaultLexicalMapper: java.util.regex.Pattern utf8ProDrop> = $r14;	$r15 = staticinvoke <java.util.regex.Pattern: java.util.regex.Pattern compile(java.lang.String)>("^-+|-+$");	r0.<edu.stanford.nlp.international.arabic.pipeline.DefaultLexicalMapper: java.util.regex.Pattern segmentationMarker> = $r15;	$r16 = staticinvoke <java.util.regex.Pattern: java.util.regex.Pattern compile(java.lang.String)>("\\+");	r0.<edu.stanford.nlp.international.arabic.pipeline.DefaultLexicalMapper: java.util.regex.Pattern morphemeBoundary> = $r16;	$r17 = staticinvoke <java.util.regex.Pattern: java.util.regex.Pattern compile(java.lang.String)>("\\d+");	r0.<edu.stanford.nlp.international.arabic.pipeline.DefaultLexicalMapper: java.util.regex.Pattern hasDigit> = $r17;	r0.<edu.stanford.nlp.international.arabic.pipeline.DefaultLexicalMapper: boolean useATBVocalizedSectionMapping> = 0;	r0.<edu.stanford.nlp.international.arabic.pipeline.DefaultLexicalMapper: boolean stripMorphemeMarkersInUTF8> = 0;	r0.<edu.stanford.nlp.international.arabic.pipeline.DefaultLexicalMapper: boolean stripSegmentationMarkersInUTF8> = 0;	r0.<edu.stanford.nlp.international.arabic.pipeline.DefaultLexicalMapper: java.lang.String parentTagString> = "PUNC LATIN -NONE-";	r0.<edu.stanford.nlp.international.arabic.pipeline.DefaultLexicalMapper: java.lang.String utf8CliticString> = "\u0644 \u0641 \u0648 \u0645\u0627 \u0647 \u0647\u0627 \u0647\u0645 \u0647\u0646 \u0646\u0627 \u0643\u0645 \u062a\u0646 \u062a\u0645 \u0649 \u064a \u0647\u0645\u0627 \u0643 \u0628 \u0645";	$r18 = "PUNC LATIN -NONE-";	$r19 = virtualinvoke $r18.<java.lang.String: java.lang.String[] split(java.lang.String)>("\\s+");	$r20 = staticinvoke <java.util.Arrays: java.util.List asList(java.lang.Object[])>($r19);	$r21 = staticinvoke <edu.stanford.nlp.util.Generics: java.util.Set newHashSet(java.util.Collection)>($r20);	$r22 = staticinvoke <java.util.Collections: java.util.Set unmodifiableSet(java.util.Set)>($r21);	r0.<edu.stanford.nlp.international.arabic.pipeline.DefaultLexicalMapper: java.util.Set parentTagsToEscape> = $r22;	$r23 = new edu.stanford.nlp.international.arabic.Buckwalter;	specialinvoke $r23.<edu.stanford.nlp.international.arabic.Buckwalter: void <init>(boolean)>(1);	r24 = virtualinvoke $r23.<edu.stanford.nlp.international.arabic.Buckwalter: java.lang.String apply(java.lang.String)>("\u0644 \u0641 \u0648 \u0645\u0627 \u0647 \u0647\u0627 \u0647\u0645 \u0647\u0646 \u0646\u0627 \u0643\u0645 \u062a\u0646 \u062a\u0645 \u0649 \u064a \u0647\u0645\u0627 \u0643 \u0628 \u0645");	$r25 = virtualinvoke r24.<java.lang.String: java.lang.String[] split(java.lang.String)>("\\s+");	$r26 = staticinvoke <java.util.Arrays: java.util.List asList(java.lang.Object[])>($r25);	$r27 = staticinvoke <edu.stanford.nlp.util.Generics: java.util.Set newHashSet(java.util.Collection)>($r26);	$r28 = staticinvoke <java.util.Collections: java.util.Set unmodifiableSet(java.util.Set)>($r27);	r0.<edu.stanford.nlp.international.arabic.pipeline.DefaultLexicalMapper: java.util.Set bwClitics> = $r28;	return
;block_num 1