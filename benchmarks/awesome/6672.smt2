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

(declare-sort var2704 0)
(declare-sort var550 0)
(declare-sort var336 0)
(declare-sort var590 0)
(declare-sort var489 0)
(declare-sort var3313 0)
(declare-sort var3761 0)
(declare-sort var2885 0)
(declare-sort var3275 0)
(declare-sort var2622 0)
(declare-sort var200 0)
(declare-sort var1820 0)
(declare-sort var2698 0)
(declare-sort var750 0)
(declare-sort var3747 0)
(declare-sort var3067 0)
(declare-sort var1292 0)
(declare-sort var605 0)
(declare-sort var3076 0)
(declare-sort var1286 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var590_getPrintWriter/-184773786 (String) var336)
(declare-fun store/-1111572071 (var550 var489 String) void)
(declare-fun cast-from-var336-to-var489 (var336) var489)
(declare-fun close/2116439267 (var336) void)
(declare-fun var3313-init () var3313)
(declare-fun <init>/-325640736 (var3313) void)
(declare-fun var2885_asList/1779083644 ((Array Int var3275)) var3761)
(declare-fun cast-from-__Array__Int__String__-to-__Array__Int__var3275__ ((Array Int String)) (Array Int var3275))
(declare-fun var3761_addAll/-525367613 (var3761 var2622) Bool)
(declare-fun cast-from-var3313-to-var3761 (var3313) var3761)
(declare-fun cast-from-var3761-to-var2622 (var3761) var2622)
(declare-fun var3761_add/328494887 (var3761 var3275) Bool)
(declare-fun cast-from-String-to-var3275 (String) var3275)
(declare-fun var200-init () var200)
(declare-fun <init>/1141931871 (var200 var3761) void)
(declare-fun var2698_getenv/1264327901 () var1820)
(declare-fun environment/-2095049904 (var200) var1820)
(declare-fun var1820_putAll/1656389889 (var1820 var1820) void)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(declare-fun command/-1952606062 (var200) var3761)
(declare-fun var3067_join/1441172726 (var1292 String) String)
(declare-fun cast-from-var3761-to-var1292 (var3761) var1292)
(define-fun toString/-2075883882 ((s String)) String s)
(declare-fun info/114590825 (var750 String) void)
(declare-fun var605-init () var605)
(declare-fun <init>/358169345 (var605) void)
(declare-fun var336-init () var336)
(declare-fun var3076-init () var3076)
(declare-fun <init>/203560862 (var3076 var489) void)
(declare-fun cast-from-var605-to-var489 (var605) var489)
(declare-fun <init>/-1864438596 (var336 var489) void)
(declare-fun cast-from-var3076-to-var489 (var3076) var489)
(declare-fun var1286_run/-1749948779 (var200 var489 var489) void)
(declare-fun toString/138175384 (var605) String)
(define-fun length/-134980193 ((s String)) Int (str.len s))
(declare-const null-String String)
(declare-const null-var550 var550)
(declare-const null-NullType var2704)
(declare-const var3747-logger var750)
(declare-const var3298 String) ; Statement: r4 := @parameter0: java.lang.String 
(assert (not (= var3298 null-String)))
(declare-const var2280 var550) ; Statement: r2 := @parameter1: java.util.Properties 
(assert (not (= var2280 null-var550)))
(declare-const var3680 String) ; Statement: r0 := @parameter2: java.lang.String 
(assert (not (= var3680 null-String)))
(define-const var553 var336 (var590_getPrintWriter/-184773786 var3680)) ; Statement: r1 = staticinvoke <edu.stanford.nlp.io.IOUtils: java.io.PrintWriter getPrintWriter(java.lang.String)>(r0) 
(assert true)
;(assert (store/-1111572071 var2280 (cast-from-var336-to-var489 var553) null-String)) ; Statement: virtualinvoke r2.<java.util.Properties: void store(java.io.Writer,java.lang.String)>(r1, null) 

(declare-const var2280!1 var550)
(declare-const var553!1 var336)
(declare-const var1969 var2704)
(assert true)
;(assert (close/2116439267 var553!1)) ; Statement: virtualinvoke r1.<java.io.PrintWriter: void close()>() 

(declare-const var553!2 var336)
(define-const var848 var3313 var3313-init) ; Statement: $r3 = new java.util.ArrayList 
(assert true)
;(assert (<init>/-325640736 var848)) ; Statement: specialinvoke $r3.<java.util.ArrayList: void <init>()>() 

(declare-const var848!1 var3313)
; split operation: var469 = var3298.split("\u005cs+") ; Statement: $r5 = virtualinvoke r4.<java.lang.String: java.lang.String[] split(java.lang.String)>("\\s+") 
(define-const var1716 var3761 (var2885_asList/1779083644 (cast-from-__Array__Int__String__-to-__Array__Int__var3275__ var469))) ; Statement: $r6 = staticinvoke <java.util.Arrays: java.util.List asList(java.lang.Object[])>($r5) 
;(assert (var3761_addAll/-525367613 (cast-from-var3313-to-var3761 var848!1) (cast-from-var3761-to-var2622 var1716))) ; Statement: interfaceinvoke $r3.<java.util.List: boolean addAll(java.util.Collection)>($r6) 

(declare-const var848!2 var3313)
(declare-const var1716!1 var3761)
;(assert (var3761_add/328494887 (cast-from-var3313-to-var3761 var848!2) (cast-from-String-to-var3275 "-props"))) ; Statement: interfaceinvoke $r3.<java.util.List: boolean add(java.lang.Object)>("-props") 

(declare-const var848!3 var3313)
(declare-const var1775 String)
;(assert (var3761_add/328494887 (cast-from-var3313-to-var3761 var848!3) (cast-from-String-to-var3275 var3680))) ; Statement: interfaceinvoke $r3.<java.util.List: boolean add(java.lang.Object)>(r0) 

(declare-const var848!4 var3313)
(declare-const var3680!1 String)
(define-const var3308 var200 var200-init) ; Statement: $r7 = new java.lang.ProcessBuilder 
(assert true)
;(assert (<init>/1141931871 var3308 (cast-from-var3313-to-var3761 var848!4))) ; Statement: specialinvoke $r7.<java.lang.ProcessBuilder: void <init>(java.util.List)>($r3) 

(declare-const var3308!1 var200)
(declare-const var848!5 var3313)
(define-const var3097 var1820 var2698_getenv/1264327901) ; Statement: r8 = staticinvoke <java.lang.System: java.util.Map getenv()>() 
(assert true)
(define-const var1322 var1820 (environment/-2095049904 var3308!1)) ; Statement: r9 = virtualinvoke $r7.<java.lang.ProcessBuilder: java.util.Map environment()>() 
;(assert (var1820_putAll/1656389889 var1322 var3097)) ; Statement: interfaceinvoke r9.<java.util.Map: void putAll(java.util.Map)>(r8) 

(declare-const var1322!1 var1820)
(declare-const var3097!1 var1820)
(define-const var566 var750 var3747-logger) ; Statement: $r11 = <edu.stanford.nlp.dcoref.SieveCoreferenceSystem: java.util.logging.Logger logger> 
(define-const var1694 String String-init) ; Statement: $r10 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var1694)) ; Statement: specialinvoke $r10.<java.lang.StringBuilder: void <init>()>() 
(declare-const var1694!1 String)
(assert (= var1694!1 ""))
(assert true)
(define-const var2356 String (append/672562846 var1694!1 "Running distributed coref:")) ; Statement: $r14 = virtualinvoke $r10.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Running distributed coref:") 
(declare-const var1694!2 String)
(assert (= var1694!2 (str.++ var1694!1 "Running distributed coref:")))
(assert true)
(define-const var654 var3761 (command/-1952606062 var3308!1)) ; Statement: $r12 = virtualinvoke $r7.<java.lang.ProcessBuilder: java.util.List command()>() 
(define-const var3215 String (var3067_join/1441172726 (cast-from-var3761-to-var1292 var654) " ")) ; Statement: $r13 = staticinvoke <edu.stanford.nlp.util.StringUtils: java.lang.String join(java.lang.Iterable,java.lang.String)>($r12, " ") 
(assert true)
(define-const var3141 String (append/672562846 var2356 var3215)) ; Statement: $r15 = virtualinvoke $r14.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r13) 
(declare-const var2356!1 String)
(assert (= var2356!1 (str.++ var2356 var3215)))
(assert true)
(define-const var1471 String (toString/-2075883882 var3141)) ; Statement: $r16 = virtualinvoke $r15.<java.lang.StringBuilder: java.lang.String toString()>() 
(assert true)
;(assert (info/114590825 var566 var1471)) ; Statement: virtualinvoke $r11.<java.util.logging.Logger: void info(java.lang.String)>($r16) 

(declare-const var566!1 var750)
(declare-const var1471!1 String)
(define-const var3108 var605 var605-init) ; Statement: $r17 = new java.io.StringWriter 
(assert true)
;(assert (<init>/358169345 var3108)) ; Statement: specialinvoke $r17.<java.io.StringWriter: void <init>()>() 

(declare-const var3108!1 var605)
(define-const var2562 var605 var605-init) ; Statement: $r18 = new java.io.StringWriter 
(assert true)
;(assert (<init>/358169345 var2562)) ; Statement: specialinvoke $r18.<java.io.StringWriter: void <init>()>() 

(declare-const var2562!1 var605)
(define-const var3291 var336 var336-init) ; Statement: $r19 = new java.io.PrintWriter 
(define-const var3663 var3076 var3076-init) ; Statement: $r20 = new java.io.BufferedWriter 
(assert true)
;(assert (<init>/203560862 var3663 (cast-from-var605-to-var489 var3108!1))) ; Statement: specialinvoke $r20.<java.io.BufferedWriter: void <init>(java.io.Writer)>($r17) 

(declare-const var3663!1 var3076)
(declare-const var3108!2 var605)
(assert true)
;(assert (<init>/-1864438596 var3291 (cast-from-var3076-to-var489 var3663!1))) ; Statement: specialinvoke $r19.<java.io.PrintWriter: void <init>(java.io.Writer)>($r20) 

(declare-const var3291!1 var336)
(declare-const var3663!2 var3076)
(define-const var2938 var336 var336-init) ; Statement: $r21 = new java.io.PrintWriter 
(define-const var1271 var3076 var3076-init) ; Statement: $r22 = new java.io.BufferedWriter 
(assert true)
;(assert (<init>/203560862 var1271 (cast-from-var605-to-var489 var2562!1))) ; Statement: specialinvoke $r22.<java.io.BufferedWriter: void <init>(java.io.Writer)>($r18) 

(declare-const var1271!1 var3076)
(declare-const var2562!2 var605)
(assert true)
;(assert (<init>/-1864438596 var2938 (cast-from-var3076-to-var489 var1271!1))) ; Statement: specialinvoke $r21.<java.io.PrintWriter: void <init>(java.io.Writer)>($r22) 

(declare-const var2938!1 var336)
(declare-const var1271!2 var3076)
;(assert (var1286_run/-1749948779 var3308!1 (cast-from-var336-to-var489 var3291!1) (cast-from-var336-to-var489 var2938!1))) ; Statement: staticinvoke <edu.stanford.nlp.util.SystemUtils: void run(java.lang.ProcessBuilder,java.io.Writer,java.io.Writer)>($r7, $r19, $r21) 

(declare-const var3308!2 var200)
(declare-const var3291!2 var336)
(declare-const var2938!2 var336)
(assert true)
;(assert (close/2116439267 var3291!2)) ; Statement: virtualinvoke $r19.<java.io.PrintWriter: void close()>() 

(declare-const var3291!3 var336)
(assert true)
;(assert (close/2116439267 var2938!2)) ; Statement: virtualinvoke $r21.<java.io.PrintWriter: void close()>() 

(declare-const var2938!3 var336)
(assert true)
(define-const var1574 String (toString/138175384 var3108!2)) ; Statement: r23 = virtualinvoke $r17.<java.io.StringWriter: java.lang.String toString()>() 
(assert true)
(define-const var1604 String (toString/138175384 var2562!2)) ; Statement: r24 = virtualinvoke $r18.<java.io.StringWriter: java.lang.String toString()>() 
(define-const var1699 var750 var3747-logger) ; Statement: $r26 = <edu.stanford.nlp.dcoref.SieveCoreferenceSystem: java.util.logging.Logger logger> 
(define-const var2993 String String-init) ; Statement: $r25 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var2993)) ; Statement: specialinvoke $r25.<java.lang.StringBuilder: void <init>()>() 
(declare-const var2993!1 String)
(assert (= var2993!1 ""))
(assert true)
(define-const var1656 String (append/672562846 var2993!1 "Finished distributed coref: ")) ; Statement: $r27 = virtualinvoke $r25.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Finished distributed coref: ") 
(declare-const var2993!2 String)
(assert (= var2993!2 (str.++ var2993!1 "Finished distributed coref: ")))
(assert true)
(define-const var2461 String (append/672562846 var1656 var3298)) ; Statement: $r28 = virtualinvoke $r27.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r4) 
(declare-const var1656!1 String)
(assert (= var1656!1 (str.++ var1656 var3298)))
(assert true)
(define-const var3594 String (append/672562846 var2461 ", props=")) ; Statement: $r29 = virtualinvoke $r28.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(", props=") 
(declare-const var2461!1 String)
(assert (= var2461!1 (str.++ var2461 ", props=")))
(assert true)
(define-const var215 String (append/672562846 var3594 var3680!1)) ; Statement: $r30 = virtualinvoke $r29.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r0) 
(declare-const var3594!1 String)
(assert (= var3594!1 (str.++ var3594 var3680!1)))
(assert true)
(define-const var443 String (toString/-2075883882 var215)) ; Statement: $r31 = virtualinvoke $r30.<java.lang.StringBuilder: java.lang.String toString()>() 
(assert true)
;(assert (info/114590825 var1699 var443)) ; Statement: virtualinvoke $r26.<java.util.logging.Logger: void info(java.lang.String)>($r31) 

(declare-const var1699!1 var750)
(declare-const var443!1 String)
(define-const var2820 var750 var3747-logger) ; Statement: $r33 = <edu.stanford.nlp.dcoref.SieveCoreferenceSystem: java.util.logging.Logger logger> 
(define-const var2015 String String-init) ; Statement: $r32 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var2015)) ; Statement: specialinvoke $r32.<java.lang.StringBuilder: void <init>()>() 
(declare-const var2015!1 String)
(assert (= var2015!1 ""))
(assert true)
(define-const var1056 String (append/672562846 var2015!1 "Output: ")) ; Statement: $r34 = virtualinvoke $r32.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Output: ") 
(declare-const var2015!2 String)
(assert (= var2015!2 (str.++ var2015!1 "Output: ")))
(assert true)
(define-const var2137 String (append/672562846 var1056 var1574)) ; Statement: $r35 = virtualinvoke $r34.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r23) 
(declare-const var1056!1 String)
(assert (= var1056!1 (str.++ var1056 var1574)))
(assert true)
(define-const var3931 String (toString/-2075883882 var2137)) ; Statement: $r36 = virtualinvoke $r35.<java.lang.StringBuilder: java.lang.String toString()>() 
(assert true)
;(assert (info/114590825 var2820 var3931)) ; Statement: virtualinvoke $r33.<java.util.logging.Logger: void info(java.lang.String)>($r36) 

(declare-const var2820!1 var750)
(declare-const var3931!1 String)
(assert true)
(define-const var2643 Int (length/-134980193 var1604)) ; Statement: $i0 = virtualinvoke r24.<java.lang.String: int length()>() 
 ; Statement: if $i0 <= 0 goto return 
(assert (<= var2643 0)) ; Cond: $i0 <= 0 
 ; Statement: return 
(check-sat)
; {var590_getPrintWriter/-184773786=([java.lang.String], java.io.PrintWriter), store/-1111572071=([java.util.Properties, java.io.Writer, java.lang.String], void), cast-from-var336-to-var489=([java.io.PrintWriter], java.io.Writer), close/2116439267=([java.io.PrintWriter], void), var3313-init=([], java.util.ArrayList), <init>/-325640736=([java.util.ArrayList], void), var2885_asList/1779083644=([java.lang.Object[]], java.util.List), cast-from-__Array__Int__String__-to-__Array__Int__var3275__=([java.lang.String[]], java.lang.Object[]), var3761_addAll/-525367613=([java.util.List, java.util.Collection], boolean), cast-from-var3313-to-var3761=([java.util.ArrayList], java.util.List), cast-from-var3761-to-var2622=([java.util.List], java.util.Collection), var3761_add/328494887=([java.util.List, java.lang.Object], boolean), cast-from-String-to-var3275=([java.lang.String], java.lang.Object), var200-init=([], java.lang.ProcessBuilder), <init>/1141931871=([java.lang.ProcessBuilder, java.util.List], void), var2698_getenv/1264327901=([], java.util.Map), environment/-2095049904=([java.lang.ProcessBuilder], java.util.Map), var1820_putAll/1656389889=([java.util.Map, java.util.Map], void), String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), command/-1952606062=([java.lang.ProcessBuilder], java.util.List), var3067_join/1441172726=([java.lang.Iterable, java.lang.String], java.lang.String), cast-from-var3761-to-var1292=([java.util.List], java.lang.Iterable), toString/-2075883882=([java.lang.StringBuilder], java.lang.String), info/114590825=([java.util.logging.Logger, java.lang.String], void), var605-init=([], java.io.StringWriter), <init>/358169345=([java.io.StringWriter], void), var336-init=([], java.io.PrintWriter), var3076-init=([], java.io.BufferedWriter), <init>/203560862=([java.io.BufferedWriter, java.io.Writer], void), cast-from-var605-to-var489=([java.io.StringWriter], java.io.Writer), <init>/-1864438596=([java.io.PrintWriter, java.io.Writer], void), cast-from-var3076-to-var489=([java.io.BufferedWriter], java.io.Writer), var1286_run/-1749948779=([java.lang.ProcessBuilder, java.io.Writer, java.io.Writer], void), toString/138175384=([java.io.StringWriter], java.lang.String), length/-134980193=([java.lang.String], int)}
; {var3298=r4, var2704=null_type, var550=java.util.Properties, var2280=r2, var3680=r0, var336=java.io.PrintWriter, var590=edu.stanford.nlp.io.IOUtils, var553=r1, var489=java.io.Writer, var1969=null, var3313=java.util.ArrayList, var848=$r3, var469=$r5, var3761=java.util.List, var2885=java.util.Arrays, var3275=java.lang.Object, var1716=$r6, var2622=java.util.Collection, var1775="-props", var200=java.lang.ProcessBuilder, var3308=$r7, var1820=java.util.Map, var2698=java.lang.System, var3097=r8, var1322=r9, var750=java.util.logging.Logger, var3747=edu.stanford.nlp.dcoref.SieveCoreferenceSystem, var566=$r11, var1694=$r10, var2356=$r14, var654=$r12, var3067=edu.stanford.nlp.util.StringUtils, var1292=java.lang.Iterable, var3215=$r13, var3141=$r15, var1471=$r16, var605=java.io.StringWriter, var3108=$r17, var2562=$r18, var3291=$r19, var3076=java.io.BufferedWriter, var3663=$r20, var2938=$r21, var1271=$r22, var1286=edu.stanford.nlp.util.SystemUtils, var1574=r23, var1604=r24, var1699=$r26, var2993=$r25, var1656=$r27, var2461=$r28, var3594=$r29, var215=$r30, var443=$r31, var2820=$r33, var2015=$r32, var1056=$r34, var2137=$r35, var3931=$r36, var2643=$i0}
; {r4=var3298, null_type=var2704, java.util.Properties=var550, r2=var2280, r0=var3680, java.io.PrintWriter=var336, edu.stanford.nlp.io.IOUtils=var590, r1=var553, java.io.Writer=var489, null=var1969, java.util.ArrayList=var3313, $r3=var848, $r5=var469, java.util.List=var3761, java.util.Arrays=var2885, java.lang.Object=var3275, $r6=var1716, java.util.Collection=var2622, "-props"=var1775, java.lang.ProcessBuilder=var200, $r7=var3308, java.util.Map=var1820, java.lang.System=var2698, r8=var3097, r9=var1322, java.util.logging.Logger=var750, edu.stanford.nlp.dcoref.SieveCoreferenceSystem=var3747, $r11=var566, $r10=var1694, $r14=var2356, $r12=var654, edu.stanford.nlp.util.StringUtils=var3067, java.lang.Iterable=var1292, $r13=var3215, $r15=var3141, $r16=var1471, java.io.StringWriter=var605, $r17=var3108, $r18=var2562, $r19=var3291, java.io.BufferedWriter=var3076, $r20=var3663, $r21=var2938, $r22=var1271, edu.stanford.nlp.util.SystemUtils=var1286, r23=var1574, r24=var1604, $r26=var1699, $r25=var2993, $r27=var1656, $r28=var2461, $r29=var3594, $r30=var215, $r31=var443, $r33=var2820, $r32=var2015, $r34=var1056, $r35=var2137, $r36=var3931, $i0=var2643}
;seq <java.lang.String: java.lang.String[] split(java.lang.String)>;	<java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<edu.stanford.nlp.util.StringUtils: java.lang.String join(java.lang.Iterable,java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>;	<java.io.StringWriter: java.lang.String toString()>;	<java.io.StringWriter: java.lang.String toString()>;	<java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>;	<java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>;	<java.lang.String: int length()>
;cnt {"<java.lang.String: java.lang.String[] split(java.lang.String)>": 1,"<java.lang.StringBuilder: void <init>()>": 3,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 8,"<edu.stanford.nlp.util.StringUtils: java.lang.String join(java.lang.Iterable,java.lang.String)>": 1,"<java.lang.StringBuilder: java.lang.String toString()>": 3,"<java.lang.String: int length()>": 1}
;stmts r4 := @parameter0: java.lang.String;	r2 := @parameter1: java.util.Properties;	r0 := @parameter2: java.lang.String;	r1 = staticinvoke <edu.stanford.nlp.io.IOUtils: java.io.PrintWriter getPrintWriter(java.lang.String)>(r0);	virtualinvoke r2.<java.util.Properties: void store(java.io.Writer,java.lang.String)>(r1, null);	virtualinvoke r1.<java.io.PrintWriter: void close()>();	$r3 = new java.util.ArrayList;	specialinvoke $r3.<java.util.ArrayList: void <init>()>();	$r5 = virtualinvoke r4.<java.lang.String: java.lang.String[] split(java.lang.String)>("\\s+");	$r6 = staticinvoke <java.util.Arrays: java.util.List asList(java.lang.Object[])>($r5);	interfaceinvoke $r3.<java.util.List: boolean addAll(java.util.Collection)>($r6);	interfaceinvoke $r3.<java.util.List: boolean add(java.lang.Object)>("-props");	interfaceinvoke $r3.<java.util.List: boolean add(java.lang.Object)>(r0);	$r7 = new java.lang.ProcessBuilder;	specialinvoke $r7.<java.lang.ProcessBuilder: void <init>(java.util.List)>($r3);	r8 = staticinvoke <java.lang.System: java.util.Map getenv()>();	r9 = virtualinvoke $r7.<java.lang.ProcessBuilder: java.util.Map environment()>();	interfaceinvoke r9.<java.util.Map: void putAll(java.util.Map)>(r8);	$r11 = <edu.stanford.nlp.dcoref.SieveCoreferenceSystem: java.util.logging.Logger logger>;	$r10 = new java.lang.StringBuilder;	specialinvoke $r10.<java.lang.StringBuilder: void <init>()>();	$r14 = virtualinvoke $r10.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Running distributed coref:");	$r12 = virtualinvoke $r7.<java.lang.ProcessBuilder: java.util.List command()>();	$r13 = staticinvoke <edu.stanford.nlp.util.StringUtils: java.lang.String join(java.lang.Iterable,java.lang.String)>($r12, " ");	$r15 = virtualinvoke $r14.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r13);	$r16 = virtualinvoke $r15.<java.lang.StringBuilder: java.lang.String toString()>();	virtualinvoke $r11.<java.util.logging.Logger: void info(java.lang.String)>($r16);	$r17 = new java.io.StringWriter;	specialinvoke $r17.<java.io.StringWriter: void <init>()>();	$r18 = new java.io.StringWriter;	specialinvoke $r18.<java.io.StringWriter: void <init>()>();	$r19 = new java.io.PrintWriter;	$r20 = new java.io.BufferedWriter;	specialinvoke $r20.<java.io.BufferedWriter: void <init>(java.io.Writer)>($r17);	specialinvoke $r19.<java.io.PrintWriter: void <init>(java.io.Writer)>($r20);	$r21 = new java.io.PrintWriter;	$r22 = new java.io.BufferedWriter;	specialinvoke $r22.<java.io.BufferedWriter: void <init>(java.io.Writer)>($r18);	specialinvoke $r21.<java.io.PrintWriter: void <init>(java.io.Writer)>($r22);	staticinvoke <edu.stanford.nlp.util.SystemUtils: void run(java.lang.ProcessBuilder,java.io.Writer,java.io.Writer)>($r7, $r19, $r21);	virtualinvoke $r19.<java.io.PrintWriter: void close()>();	virtualinvoke $r21.<java.io.PrintWriter: void close()>();	r23 = virtualinvoke $r17.<java.io.StringWriter: java.lang.String toString()>();	r24 = virtualinvoke $r18.<java.io.StringWriter: java.lang.String toString()>();	$r26 = <edu.stanford.nlp.dcoref.SieveCoreferenceSystem: java.util.logging.Logger logger>;	$r25 = new java.lang.StringBuilder;	specialinvoke $r25.<java.lang.StringBuilder: void <init>()>();	$r27 = virtualinvoke $r25.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Finished distributed coref: ");	$r28 = virtualinvoke $r27.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r4);	$r29 = virtualinvoke $r28.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(", props=");	$r30 = virtualinvoke $r29.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r0);	$r31 = virtualinvoke $r30.<java.lang.StringBuilder: java.lang.String toString()>();	virtualinvoke $r26.<java.util.logging.Logger: void info(java.lang.String)>($r31);	$r33 = <edu.stanford.nlp.dcoref.SieveCoreferenceSystem: java.util.logging.Logger logger>;	$r32 = new java.lang.StringBuilder;	specialinvoke $r32.<java.lang.StringBuilder: void <init>()>();	$r34 = virtualinvoke $r32.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Output: ");	$r35 = virtualinvoke $r34.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r23);	$r36 = virtualinvoke $r35.<java.lang.StringBuilder: java.lang.String toString()>();	virtualinvoke $r33.<java.util.logging.Logger: void info(java.lang.String)>($r36);	$i0 = virtualinvoke r24.<java.lang.String: int length()>();	if $i0 <= 0 goto return;	return
;block_num 2