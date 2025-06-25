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

(declare-sort var3321 0)
(declare-sort var3433 0)
(declare-sort var246 0)
(declare-sort var1814 0)
(declare-sort var2139 0)
(declare-sort var278 0)
(declare-sort var3265 0)
(declare-sort var1963 0)
(declare-sort var3758 0)
(declare-sort var3679 0)
(declare-sort var692 0)
(declare-sort var3402 0)
(declare-sort var2390 0)
(declare-sort var2705 0)
(declare-sort var3501 0)
(declare-sort var3309 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-const var1814!class ClassObject)
(declare-const var3501!class ClassObject)
(declare-const var3309!class ClassObject)
(declare-fun get/-1817470621 (var2139 ClassObject) var246)
(declare-fun cast-from-var3433-to-var2139 (var3433) var2139)
(declare-fun cast-from-var246-to-String (var246) String)
(declare-fun var278-init () var278)
(declare-fun <init>/-325640736 (var278) void)
(declare-fun var1963_asList/1779083644 ((Array Int var246)) var3265)
(declare-fun cast-from-__Array__Int__String__-to-__Array__Int__var246__ ((Array Int String)) (Array Int var246))
(declare-fun <init>/2032108350 (var278 var3758) void)
(declare-fun cast-from-var3265-to-var3758 (var3265) var3758)
(declare-fun var692_bootstrap$/-2123628538 () var3679)
(declare-fun var3265_replaceAll/-1621876671 (var3265 var3679) void)
(declare-fun cast-from-var278-to-var3265 (var278) var3265)
(declare-fun arr-String-init () (Array Int String))
(declare-fun var3265_removeAll/1163467862 (var3265 var3758) Bool)
(declare-fun String_join/1594745010 (String var2390) String)
(define-fun cast-from-String-to-String ((arg String)) String arg)
(declare-fun cast-from-var278-to-var2390 (var278) var2390)
(declare-fun replaceAll/1692887130 (String String String) String)
(define-fun substring/-1240304868 ((s String) (begin Int) (end Int)) String (str.substr s begin (- end begin)))
(declare-fun statTokSent/-806218197 (var3321) var2705)
(declare-fun tokenize/-295523487 (var2705 String) var3265)
(declare-fun var3265_iterator/-912451715 (var3265) Iterator)
(declare-fun Iterator_hasNext/-1669924200 (Iterator) Bool)
(declare-fun set/1958680634 (var2139 ClassObject var246) var246)
(declare-fun cast-from-var278-to-var246 (var278) var246)
(declare-fun var3321_setNewlineStatus/891011288 (var3265) void)
(declare-const null-var3321 var3321)
(declare-const null-var3433 var3433)
(declare-const null-__Array__Int__String__ (Array Int String))
(declare-const null-String String)
(declare-const var2577 var3321) ; Statement: r11 := @this: edu.stanford.nlp.pipeline.StatTokSentAnnotator 
(assert (not (= var2577 null-var3321)))
(declare-const var3908 var3433) ; Statement: r0 := @parameter0: edu.stanford.nlp.pipeline.Annotation 
(assert (not (= var3908 null-var3433)))
(assert true)
(define-const var1031 var246 (get/-1817470621 (cast-from-var3433-to-var2139 var3908) var1814!class)) ; Statement: $r1 = virtualinvoke r0.<edu.stanford.nlp.pipeline.Annotation: java.lang.Object get(java.lang.Class)>(class "Ledu/stanford/nlp/ling/CoreAnnotations$TextAnnotation;") 
(define-const var1594 String (cast-from-var246-to-String var1031)) ; Statement: r2 = (java.lang.String) $r1 
(define-const var2979 var278 var278-init) ; Statement: $r3 = new java.util.ArrayList 
(assert true)
;(assert (<init>/-325640736 var2979)) ; Statement: specialinvoke $r3.<java.util.ArrayList: void <init>()>() 

(declare-const var2979!1 var278)
(define-const var2718 var278 var278-init) ; Statement: $r4 = new java.util.ArrayList 
; split operation: var2647 = var1594.split("\n") ; Statement: $r5 = virtualinvoke r2.<java.lang.String: java.lang.String[] split(java.lang.String)>("\n") 
(define-const var3135 var3265 (var1963_asList/1779083644 (cast-from-__Array__Int__String__-to-__Array__Int__var246__ var2647))) ; Statement: $r6 = staticinvoke <java.util.Arrays: java.util.List asList(java.lang.Object[])>($r5) 
(assert true)
;(assert (<init>/2032108350 var2718 (cast-from-var3265-to-var3758 var3135))) ; Statement: specialinvoke $r4.<java.util.ArrayList: void <init>(java.util.Collection)>($r6) 

(declare-const var2718!1 var278)
(declare-const var3135!1 var3265)
(define-const var2884 var3679 var692_bootstrap$/-2123628538) ; Statement: $r7 = staticinvoke <edu.stanford.nlp.pipeline.StatTokSentAnnotator$lambda_annotate_0__675: java.util.function.UnaryOperator bootstrap$()>() 
;(assert (var3265_replaceAll/-1621876671 (cast-from-var278-to-var3265 var2718!1) var2884)) ; Statement: interfaceinvoke $r4.<java.util.List: void replaceAll(java.util.function.UnaryOperator)>($r7) 

(declare-const var2718!2 var278)
(declare-const var2884!1 var3679)
(define-const var1901 (Array Int String) arr-String-init) ; Statement: $r8 = newarray (java.lang.String)[2] 
(declare-const var1901!1 (Array Int String))
(assert (not (= var1901!1 null-__Array__Int__String__)))
(assert (= (select var1901!1 0) "")) ; Statement: $r8[0] = "" 
(declare-const var1901!2 (Array Int String))
(assert (not (= var1901!2 null-__Array__Int__String__)))
(assert (= (select var1901!2 1) null-String)) ; Statement: $r8[1] = null 
(define-const var553 var3265 (var1963_asList/1779083644 (cast-from-__Array__Int__String__-to-__Array__Int__var246__ var1901!2))) ; Statement: $r9 = staticinvoke <java.util.Arrays: java.util.List asList(java.lang.Object[])>($r8) 
;(assert (var3265_removeAll/1163467862 (cast-from-var278-to-var3265 var2718!2) (cast-from-var3265-to-var3758 var553))) ; Statement: interfaceinvoke $r4.<java.util.List: boolean removeAll(java.util.Collection)>($r9) 

(declare-const var2718!3 var278)
(declare-const var553!1 var3265)
(define-const var3732 String (String_join/1594745010 (cast-from-String-to-String "\n") (cast-from-var278-to-var2390 var2718!3))) ; Statement: r30 = staticinvoke <java.lang.String: java.lang.String join(java.lang.CharSequence,java.lang.Iterable)>("\n", $r4) 
(assert true)
(define-const var3816 String (replaceAll/1692887130 var3732 "(?:\u005cr\u005cn\u005cr\u005cn|\u005cr\u005cr|\u005cn\u005cn)[\u005cr\u005cn]*" "\u00a7")) ; Statement: r31 = virtualinvoke r30.<java.lang.String: java.lang.String replaceAll(java.lang.String,java.lang.String)>("(?:\\r\\n\\r\\n|\\r\\r|\\n\\n)[\\r\\n]*", "\u00a7") 
(assert (= (replaceAll/1692887130 var3732 "(?:\u005cr\u005cn\u005cr\u005cn|\u005cr\u005cr|\u005cn\u005cn)[\u005cr\u005cn]*" "\u00a7") (str.replace_re_all var3732 (re.++ (re.union (str.to_re "?:\u{005c}u{000d}\u{005c}u{000a}\u{005c}u{000d}\u{005c}u{000a}") (str.to_re "\u{005c}u{000d}\u{005c}u{000d}") (str.to_re "\u{005c}u{000a}\u{005c}u{000a}")) (re.* (re.union (str.to_re "\u{005c}u{000d}") (str.to_re "\u{005c}u{000a}")))) "\u00a7")))
(assert true)
(define-const var2060 String (replaceAll/1692887130 var3816 "[\u005cr|\u005cn]+" " ")) ; Statement: r32 = virtualinvoke r31.<java.lang.String: java.lang.String replaceAll(java.lang.String,java.lang.String)>("[\\r|\\n]+", " ") 
(assert (= (replaceAll/1692887130 var3816 "[\u005cr|\u005cn]+" " ") (str.replace_re_all var3816 (re.+ (re.union (str.to_re "\u{005c}u{000d}") (str.to_re "|") (str.to_re "\u{005c}u{000a}"))) " ")))
(assert true)
(define-const var46 String (replaceAll/1692887130 var2060 "[ ]+" " ")) ; Statement: r33 = virtualinvoke r32.<java.lang.String: java.lang.String replaceAll(java.lang.String,java.lang.String)>("[ ]+", " ") 
(assert (= (replaceAll/1692887130 var2060 "[ ]+" " ") (str.replace_re_all var2060 (re.+ (str.to_re " ")) " ")))
(assert (and true (and (>= 0 0) (>= (str.len var46) 1) (>= 1 0))))
(define-const var1732 String (substring/-1240304868 var46 0 1)) ; Statement: $r10 = virtualinvoke r33.<java.lang.String: java.lang.String substring(int,int)>(0, 1) 
(assert true)
(define-const var2293 Bool (= var1732 "\u00a7")) ; Statement: $z0 = virtualinvoke $r10.<java.lang.String: boolean equals(java.lang.Object)>("\u00a7") 
 ; Statement: if $z0 == 0 goto $r12 = r11.<edu.stanford.nlp.pipeline.StatTokSentAnnotator: edu.stanford.nlp.process.stattok.StatTokSent statTokSent> 
(assert (= (ite var2293 1 0) 0)) ; Cond: $z0 == 0 
(define-const var527 var2705 (statTokSent/-806218197 var2577)) ; Statement: $r12 = r11.<edu.stanford.nlp.pipeline.StatTokSentAnnotator: edu.stanford.nlp.process.stattok.StatTokSent statTokSent> 
(assert true)
(define-const var795 var3265 (tokenize/-295523487 var527 var46)) ; Statement: $r28 = virtualinvoke $r12.<edu.stanford.nlp.process.stattok.StatTokSent: java.util.List tokenize(java.lang.String)>(r33) 
(define-const var3584 var278 var278-init) ; Statement: $r13 = new java.util.ArrayList 
(assert true)
;(assert (<init>/-325640736 var3584)) ; Statement: specialinvoke $r13.<java.util.ArrayList: void <init>()>() 

(declare-const var3584!1 var278)
(define-const var3592 var278 var278-init) ; Statement: $r14 = new java.util.ArrayList 
(assert true)
;(assert (<init>/-325640736 var3592)) ; Statement: specialinvoke $r14.<java.util.ArrayList: void <init>()>() 

(declare-const var3592!1 var278)
(define-const var286 Int 0) ; Statement: i8 = 0 
(define-const var1782 Iterator (var3265_iterator/-912451715 var795)) ; Statement: $r29 = interfaceinvoke $r28.<java.util.List: java.util.Iterator iterator()>() 
(assert true) ; Non Conditional
(define-const var3743 Bool (Iterator_hasNext/-1669924200 var1782)) ; Statement: $z1 = interfaceinvoke $r29.<java.util.Iterator: boolean hasNext()>() 
 ; Statement: if $z1 == 0 goto virtualinvoke r0.<edu.stanford.nlp.pipeline.Annotation: java.lang.Object set(java.lang.Class,java.lang.Object)>(class "Ledu/stanford/nlp/ling/CoreAnnotations$TokensAnnotation;", $r14) 
(assert (= (ite var3743 1 0) 0)) ; Cond: $z1 == 0 
(assert true)
;(assert (set/1958680634 (cast-from-var3433-to-var2139 var3908) var3501!class (cast-from-var278-to-var246 var3592!1))) ; Statement: virtualinvoke r0.<edu.stanford.nlp.pipeline.Annotation: java.lang.Object set(java.lang.Class,java.lang.Object)>(class "Ledu/stanford/nlp/ling/CoreAnnotations$TokensAnnotation;", $r14) 

(declare-const var3908!1 var3433)
(declare-const var70 ClassObject)
(declare-const var3592!2 var278)
(assert true)
;(assert (set/1958680634 (cast-from-var3433-to-var2139 var3908!1) var3309!class (cast-from-var278-to-var246 var3584!1))) ; Statement: virtualinvoke r0.<edu.stanford.nlp.pipeline.Annotation: java.lang.Object set(java.lang.Class,java.lang.Object)>(class "Ledu/stanford/nlp/ling/CoreAnnotations$SentencesAnnotation;", $r13) 

(declare-const var3908!2 var3433)
(declare-const var2813 ClassObject)
(declare-const var3584!2 var278)
;(assert (var3321_setNewlineStatus/891011288 (cast-from-var278-to-var3265 var3592!2))) ; Statement: staticinvoke <edu.stanford.nlp.pipeline.StatTokSentAnnotator: void setNewlineStatus(java.util.List)>($r14) 

(declare-const var3592!3 var278)
 ; Statement: return 
(check-sat)
; {get/-1817470621=([edu.stanford.nlp.util.ArrayCoreMap, java.lang.Class], java.lang.Object), cast-from-var3433-to-var2139=([edu.stanford.nlp.pipeline.Annotation], edu.stanford.nlp.util.ArrayCoreMap), cast-from-var246-to-String=([java.lang.Object], java.lang.String), var278-init=([], java.util.ArrayList), <init>/-325640736=([java.util.ArrayList], void), var1963_asList/1779083644=([java.lang.Object[]], java.util.List), cast-from-__Array__Int__String__-to-__Array__Int__var246__=([java.lang.String[]], java.lang.Object[]), <init>/2032108350=([java.util.ArrayList, java.util.Collection], void), cast-from-var3265-to-var3758=([java.util.List], java.util.Collection), var692_bootstrap$/-2123628538=([], java.util.function.UnaryOperator), var3265_replaceAll/-1621876671=([java.util.List, java.util.function.UnaryOperator], void), cast-from-var278-to-var3265=([java.util.ArrayList], java.util.List), arr-String-init=([], java.lang.String[]), var3265_removeAll/1163467862=([java.util.List, java.util.Collection], boolean), String_join/1594745010=([java.lang.CharSequence, java.lang.Iterable], java.lang.String), cast-from-String-to-String=([java.lang.String], java.lang.CharSequence), cast-from-var278-to-var2390=([java.util.ArrayList], java.lang.Iterable), replaceAll/1692887130=([java.lang.String, java.lang.String, java.lang.String], java.lang.String), substring/-1240304868=([java.lang.String, int, int], java.lang.String), statTokSent/-806218197=([edu.stanford.nlp.pipeline.StatTokSentAnnotator], edu.stanford.nlp.process.stattok.StatTokSent), tokenize/-295523487=([edu.stanford.nlp.process.stattok.StatTokSent, java.lang.String], java.util.List), var3265_iterator/-912451715=([java.util.List], java.util.Iterator), Iterator_hasNext/-1669924200=([java.util.Iterator], boolean), set/1958680634=([edu.stanford.nlp.util.ArrayCoreMap, java.lang.Class, java.lang.Object], java.lang.Object), cast-from-var278-to-var246=([java.util.ArrayList], java.lang.Object), var3321_setNewlineStatus/891011288=([java.util.List], void)}
; {var3321=edu.stanford.nlp.pipeline.StatTokSentAnnotator, var2577=r11, var3433=edu.stanford.nlp.pipeline.Annotation, var3908=r0, var246=java.lang.Object, var1814=edu.stanford.nlp.ling.CoreAnnotations$TextAnnotation, var2139=edu.stanford.nlp.util.ArrayCoreMap, var1031=$r1, var1594=r2, var278=java.util.ArrayList, var2979=$r3, var2718=$r4, var2647=$r5, var3265=java.util.List, var1963=java.util.Arrays, var3135=$r6, var3758=java.util.Collection, var3679=java.util.function.UnaryOperator, var692=edu.stanford.nlp.pipeline.StatTokSentAnnotator$lambda_annotate_0__675, var2884=$r7, var1901=$r8, var3402=null_type, var553=$r9, var2390=java.lang.Iterable, var3732=r30, var3816=r31, var2060=r32, var46=r33, var1732=$r10, var2293=$z0, var2705=edu.stanford.nlp.process.stattok.StatTokSent, var527=$r12, var795=$r28, var3584=$r13, var3592=$r14, var286=i8, var1782=$r29, var3743=$z1, var3501=edu.stanford.nlp.ling.CoreAnnotations$TokensAnnotation, var70=class "Ledu/stanford/nlp/ling/CoreAnnotations$TokensAnnotation;", var3309=edu.stanford.nlp.ling.CoreAnnotations$SentencesAnnotation, var2813=class "Ledu/stanford/nlp/ling/CoreAnnotations$SentencesAnnotation;"}
; {edu.stanford.nlp.pipeline.StatTokSentAnnotator=var3321, r11=var2577, edu.stanford.nlp.pipeline.Annotation=var3433, r0=var3908, java.lang.Object=var246, edu.stanford.nlp.ling.CoreAnnotations$TextAnnotation=var1814, edu.stanford.nlp.util.ArrayCoreMap=var2139, $r1=var1031, r2=var1594, java.util.ArrayList=var278, $r3=var2979, $r4=var2718, $r5=var2647, java.util.List=var3265, java.util.Arrays=var1963, $r6=var3135, java.util.Collection=var3758, java.util.function.UnaryOperator=var3679, edu.stanford.nlp.pipeline.StatTokSentAnnotator$lambda_annotate_0__675=var692, $r7=var2884, $r8=var1901, null_type=var3402, $r9=var553, java.lang.Iterable=var2390, r30=var3732, r31=var3816, r32=var2060, r33=var46, $r10=var1732, $z0=var2293, edu.stanford.nlp.process.stattok.StatTokSent=var2705, $r12=var527, $r28=var795, $r13=var3584, $r14=var3592, i8=var286, $r29=var1782, $z1=var3743, edu.stanford.nlp.ling.CoreAnnotations$TokensAnnotation=var3501, class "Ledu/stanford/nlp/ling/CoreAnnotations$TokensAnnotation;"=var70, edu.stanford.nlp.ling.CoreAnnotations$SentencesAnnotation=var3309, class "Ledu/stanford/nlp/ling/CoreAnnotations$SentencesAnnotation;"=var2813}
;seq <java.lang.String: java.lang.String[] split(java.lang.String)>;	<java.lang.String: java.lang.String join(java.lang.CharSequence,java.lang.Iterable)>;	<java.lang.String: java.lang.String replaceAll(java.lang.String,java.lang.String)>;	<java.lang.String: java.lang.String replaceAll(java.lang.String,java.lang.String)>;	<java.lang.String: java.lang.String replaceAll(java.lang.String,java.lang.String)>;	<java.lang.String: java.lang.String substring(int,int)>;	<java.lang.String: boolean equals(java.lang.Object)>
;cnt {"<java.lang.String: java.lang.String[] split(java.lang.String)>": 1,"<java.lang.String: java.lang.String join(java.lang.CharSequence,java.lang.Iterable)>": 1,"<java.lang.String: java.lang.String replaceAll(java.lang.String,java.lang.String)>": 3,"<java.lang.String: java.lang.String substring(int,int)>": 1,"<java.lang.String: boolean equals(java.lang.Object)>": 1}
;stmts r11 := @this: edu.stanford.nlp.pipeline.StatTokSentAnnotator;	r0 := @parameter0: edu.stanford.nlp.pipeline.Annotation;	$r1 = virtualinvoke r0.<edu.stanford.nlp.pipeline.Annotation: java.lang.Object get(java.lang.Class)>(class "Ledu/stanford/nlp/ling/CoreAnnotations$TextAnnotation;");	r2 = (java.lang.String) $r1;	$r3 = new java.util.ArrayList;	specialinvoke $r3.<java.util.ArrayList: void <init>()>();	$r4 = new java.util.ArrayList;	$r5 = virtualinvoke r2.<java.lang.String: java.lang.String[] split(java.lang.String)>("\n");	$r6 = staticinvoke <java.util.Arrays: java.util.List asList(java.lang.Object[])>($r5);	specialinvoke $r4.<java.util.ArrayList: void <init>(java.util.Collection)>($r6);	$r7 = staticinvoke <edu.stanford.nlp.pipeline.StatTokSentAnnotator$lambda_annotate_0__675: java.util.function.UnaryOperator bootstrap$()>();	interfaceinvoke $r4.<java.util.List: void replaceAll(java.util.function.UnaryOperator)>($r7);	$r8 = newarray (java.lang.String)[2];	$r8[0] = "";	$r8[1] = null;	$r9 = staticinvoke <java.util.Arrays: java.util.List asList(java.lang.Object[])>($r8);	interfaceinvoke $r4.<java.util.List: boolean removeAll(java.util.Collection)>($r9);	r30 = staticinvoke <java.lang.String: java.lang.String join(java.lang.CharSequence,java.lang.Iterable)>("\n", $r4);	r31 = virtualinvoke r30.<java.lang.String: java.lang.String replaceAll(java.lang.String,java.lang.String)>("(?:\\r\\n\\r\\n|\\r\\r|\\n\\n)[\\r\\n]*", "\u00a7");	r32 = virtualinvoke r31.<java.lang.String: java.lang.String replaceAll(java.lang.String,java.lang.String)>("[\\r|\\n]+", " ");	r33 = virtualinvoke r32.<java.lang.String: java.lang.String replaceAll(java.lang.String,java.lang.String)>("[ ]+", " ");	$r10 = virtualinvoke r33.<java.lang.String: java.lang.String substring(int,int)>(0, 1);	$z0 = virtualinvoke $r10.<java.lang.String: boolean equals(java.lang.Object)>("\u00a7");	if $z0 == 0 goto $r12 = r11.<edu.stanford.nlp.pipeline.StatTokSentAnnotator: edu.stanford.nlp.process.stattok.StatTokSent statTokSent>;	$r12 = r11.<edu.stanford.nlp.pipeline.StatTokSentAnnotator: edu.stanford.nlp.process.stattok.StatTokSent statTokSent>;	$r28 = virtualinvoke $r12.<edu.stanford.nlp.process.stattok.StatTokSent: java.util.List tokenize(java.lang.String)>(r33);	$r13 = new java.util.ArrayList;	specialinvoke $r13.<java.util.ArrayList: void <init>()>();	$r14 = new java.util.ArrayList;	specialinvoke $r14.<java.util.ArrayList: void <init>()>();	i8 = 0;	$r29 = interfaceinvoke $r28.<java.util.List: java.util.Iterator iterator()>();	$z1 = interfaceinvoke $r29.<java.util.Iterator: boolean hasNext()>();	if $z1 == 0 goto virtualinvoke r0.<edu.stanford.nlp.pipeline.Annotation: java.lang.Object set(java.lang.Class,java.lang.Object)>(class "Ledu/stanford/nlp/ling/CoreAnnotations$TokensAnnotation;", $r14);	virtualinvoke r0.<edu.stanford.nlp.pipeline.Annotation: java.lang.Object set(java.lang.Class,java.lang.Object)>(class "Ledu/stanford/nlp/ling/CoreAnnotations$TokensAnnotation;", $r14);	virtualinvoke r0.<edu.stanford.nlp.pipeline.Annotation: java.lang.Object set(java.lang.Class,java.lang.Object)>(class "Ledu/stanford/nlp/ling/CoreAnnotations$SentencesAnnotation;", $r13);	staticinvoke <edu.stanford.nlp.pipeline.StatTokSentAnnotator: void setNewlineStatus(java.util.List)>($r14);	return
;block_num 4