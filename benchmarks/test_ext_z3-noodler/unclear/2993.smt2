(set-option :produce-unsat-cores true) ; enable generation of unsat cores
(set-option :produce-models true) ; enable model generation
(set-logic ALL)

; 统一获取长度的函数
(define-fun get_split_length ((x String) (d String) (limit Int)) Int
  (ite
    (> limit 0)
    (ite (< (str.num_splits x d) limit)
         (str.num_splits x d)
         limit)
    (str.num_splits x d)
  )
)

; 统一获取元素的函数
(define-fun get_split_element ((x String) (d String) (limit Int) (i Int)) String
  (ite
    (and (> limit 0)
         (= i (- limit 1))
         (>= (str.num_splits x d) limit))
    (str.split_rest x d (- limit 1))
    (str.split_at x d i)
  )
)

(declare-sort var1089 0)
(declare-sort var2770 0)
(declare-sort var3762 0)
(declare-sort var457 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(declare-fun getEndTime/665032330 (var1089) Int)
(declare-fun getStartTime/-1874863133 (var1089) Int)
(define-fun cast-from-Int-to-Int ((arg Int)) Int arg)
(declare-fun var2770-init () var2770)
(declare-fun <init>/1281898776 (var2770) void)
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(declare-fun append/-901862667 (String Int) String)
(declare-fun append/-1166366385 (String Int) String)
(declare-fun arr-var3762-init () (Array Int var3762))
(declare-fun Int_valueOf/-1102777585 (Int) Int)
(declare-fun cast-from-Int-to-var3762 (Int) var3762)
(declare-fun String_format/1339386452 (String (Array Int var3762)) String)
(define-fun append/-1001720160 ((s String) (tail Int)) String (str.++ s (str.from_int tail)))
(declare-fun getMessage/-1581253612 (var1089) String)
(define-fun toString/-2075883882 ((s String)) String s)
(declare-fun var457_add/328494887 (var457 var3762) Bool)
(declare-fun cast-from-var2770-to-var457 (var2770) var457)
(declare-fun cast-from-String-to-var3762 (String) var3762)
(declare-fun getSub/1235719092 (var1089) var457)
(declare-fun var457_size/-959786421 (var457) Int)
(declare-const null-var1089 var1089)
(declare-const null-Int Int)
(declare-const null-__Array__Int__var3762__ (Array Int var3762))
(declare-const var576 var1089) ; Statement: r1 := @parameter0: org.apache.dubbo.common.profiler.ProfilerEntry 
(assert (not (= var576 null-var1089)))
(declare-const var3248 Int) ; Statement: l7 := @parameter1: long 
(assert (not (= var3248 null-Int)))
(declare-const var1875 Int) ; Statement: l3 := @parameter2: long 
(assert (not (= var1875 null-Int)))
(declare-const var2847 Int) ; Statement: i15 := @parameter3: int 
(assert (not (= var2847 null-Int)))
(define-const var3836 String String-init) ; Statement: $r0 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var3836)) ; Statement: specialinvoke $r0.<java.lang.StringBuilder: void <init>()>() 
(declare-const var3836!1 String)
(assert (= var3836!1 ""))
(assert true)
(define-const var2202 Int (getEndTime/665032330 var576)) ; Statement: $l1 = virtualinvoke r1.<org.apache.dubbo.common.profiler.ProfilerEntry: long getEndTime()>() 
(assert true)
(define-const var3887 Int (getStartTime/-1874863133 var576)) ; Statement: $l0 = virtualinvoke r1.<org.apache.dubbo.common.profiler.ProfilerEntry: long getStartTime()>() 
(define-const var173 Int (- var2202 var3887)) ; Statement: l2 = $l1 - $l0 
(define-const var1100 Int (* var173 100)) ; Statement: $l4 = l2 * 100L 
(define-const var867 Int (div var1100 var1875)) ; Statement: $l5 = $l4 / l3 
(define-const var3930 Int (cast-from-Int-to-Int var867)) ; Statement: i6 = (int) $l5 
(assert true)
(define-const var3223 Int (getStartTime/-1874863133 var576)) ; Statement: $l8 = virtualinvoke r1.<org.apache.dubbo.common.profiler.ProfilerEntry: long getStartTime()>() 
(define-const var1340 Int (- var3223 var3248)) ; Statement: l9 = $l8 - l7 
(define-const var1856 var2770 var2770-init) ; Statement: $r2 = new java.util.LinkedList 
(assert true)
;(assert (<init>/1281898776 var1856)) ; Statement: specialinvoke $r2.<java.util.LinkedList: void <init>()>() 

(declare-const var1856!1 var2770)
(assert true)
(define-const var1819 String (append/672562846 var3836!1 "+-[ Offset: ")) ; Statement: $r3 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("+-[ Offset: ") 
(declare-const var3836!2 String)
(assert (= var3836!2 (str.++ var3836!1 "+-[ Offset: ")))
(define-const var3519 Int (div var1340 1000000)) ; Statement: $l10 = l9 / 1000000L 
(assert true)
(define-const var771 String (append/-901862667 var1819 var3519)) ; Statement: $r4 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(long)>($l10) 
(declare-const var1819!1 String)
(assert (str.prefixof var1819 var1819!1))
(assert true)
(define-const var1655 String (append/-1166366385 var771 46)) ; Statement: $r8 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(46) 
(declare-const var771!1 String)
(assert (str.prefixof var771 var771!1))
(define-const var643 (Array Int var3762) arr-var3762-init) ; Statement: $r5 = newarray (java.lang.Object)[1] 
(define-const var1269 Int (mod var1340 1000000)) ; Statement: $l11 = l9 % 1000000L 
(define-const var515 Int (Int_valueOf/-1102777585 var1269)) ; Statement: $r6 = staticinvoke <java.lang.Long: java.lang.Long valueOf(long)>($l11) 
(declare-const var643!1 (Array Int var3762))
(assert (not (= var643!1 null-__Array__Int__var3762__)))
(assert (= (select var643!1 0) (cast-from-Int-to-var3762 var515))) ; Statement: $r5[0] = $r6 
(define-const var1881 String (String_format/1339386452 "%06d" var643!1)) ; Statement: $r7 = staticinvoke <java.lang.String: java.lang.String format(java.lang.String,java.lang.Object[])>("%06d", $r5) 
(assert true)
(define-const var76 String (append/672562846 var1655 var1881)) ; Statement: $r9 = virtualinvoke $r8.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r7) 
(declare-const var1655!1 String)
(assert (= var1655!1 (str.++ var1655 var1881)))
(assert true)
(define-const var563 String (append/672562846 var76 "ms; Usage: ")) ; Statement: $r10 = virtualinvoke $r9.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("ms; Usage: ") 
(declare-const var76!1 String)
(assert (= var76!1 (str.++ var76 "ms; Usage: ")))
(define-const var2831 Int (div var173 1000000)) ; Statement: $l12 = l2 / 1000000L 
(assert true)
(define-const var3366 String (append/-901862667 var563 var2831)) ; Statement: $r11 = virtualinvoke $r10.<java.lang.StringBuilder: java.lang.StringBuilder append(long)>($l12) 
(declare-const var563!1 String)
(assert (str.prefixof var563 var563!1))
(assert true)
(define-const var1488 String (append/-1166366385 var3366 46)) ; Statement: $r15 = virtualinvoke $r11.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(46) 
(declare-const var3366!1 String)
(assert (str.prefixof var3366 var3366!1))
(define-const var1036 (Array Int var3762) arr-var3762-init) ; Statement: $r12 = newarray (java.lang.Object)[1] 
(define-const var1133 Int (mod var173 1000000)) ; Statement: $l13 = l2 % 1000000L 
(define-const var1735 Int (Int_valueOf/-1102777585 var1133)) ; Statement: $r13 = staticinvoke <java.lang.Long: java.lang.Long valueOf(long)>($l13) 
(declare-const var1036!1 (Array Int var3762))
(assert (not (= var1036!1 null-__Array__Int__var3762__)))
(assert (= (select var1036!1 0) (cast-from-Int-to-var3762 var1735))) ; Statement: $r12[0] = $r13 
(define-const var1014 String (String_format/1339386452 "%06d" var1036!1)) ; Statement: $r14 = staticinvoke <java.lang.String: java.lang.String format(java.lang.String,java.lang.Object[])>("%06d", $r12) 
(assert true)
(define-const var3163 String (append/672562846 var1488 var1014)) ; Statement: $r16 = virtualinvoke $r15.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r14) 
(declare-const var1488!1 String)
(assert (= var1488!1 (str.++ var1488 var1014)))
(assert true)
(define-const var2721 String (append/672562846 var3163 "ms, ")) ; Statement: $r17 = virtualinvoke $r16.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("ms, ") 
(declare-const var3163!1 String)
(assert (= var3163!1 (str.++ var3163 "ms, ")))
(assert true)
(define-const var1160 String (append/-1001720160 var2721 var3930)) ; Statement: $r18 = virtualinvoke $r17.<java.lang.StringBuilder: java.lang.StringBuilder append(int)>(i6) 
(declare-const var2721!1 String)
(assert (str.prefixof var2721 var2721!1))
(assert true)
(define-const var3990 String (append/672562846 var1160 "% ] ")) ; Statement: $r20 = virtualinvoke $r18.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("% ] ") 
(declare-const var1160!1 String)
(assert (= var1160!1 (str.++ var1160 "% ] ")))
(assert true)
(define-const var503 String (getMessage/-1581253612 var576)) ; Statement: $r19 = virtualinvoke r1.<org.apache.dubbo.common.profiler.ProfilerEntry: java.lang.String getMessage()>() 
(assert true)
;(assert (append/672562846 var3990 var503)) ; Statement: virtualinvoke $r20.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r19) 
(declare-const var3990!1 String)
(assert (= var3990!1 (str.++ var3990 var503)))
(assert true)
(define-const var2809 String (toString/-2075883882 var3836!2)) ; Statement: $r21 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.String toString()>() 
;(assert (var457_add/328494887 (cast-from-var2770-to-var457 var1856!1) (cast-from-String-to-var3762 var2809))) ; Statement: interfaceinvoke $r2.<java.util.List: boolean add(java.lang.Object)>($r21) 

(declare-const var1856!2 var2770)
(declare-const var2809!1 String)
(assert true)
(define-const var3413 var457 (getSub/1235719092 var576)) ; Statement: r22 = virtualinvoke r1.<org.apache.dubbo.common.profiler.ProfilerEntry: java.util.List getSub()>() 
(define-const var1918 Int 0) ; Statement: i18 = 0 
(define-const var1755 Int (var457_size/-959786421 var3413)) ; Statement: i14 = interfaceinvoke r22.<java.util.List: int size()>() 
(assert true) ; Non Conditional
 ; Statement: if i18 >= i14 goto return $r2 
(assert (>= var1918 var1755)) ; Cond: i18 >= i14 
 ; Statement: return $r2 
(check-sat)
; {String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), getEndTime/665032330=([org.apache.dubbo.common.profiler.ProfilerEntry], long), getStartTime/-1874863133=([org.apache.dubbo.common.profiler.ProfilerEntry], long), cast-from-Int-to-Int=([long], int), var2770-init=([], java.util.LinkedList), <init>/1281898776=([java.util.LinkedList], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), append/-901862667=([java.lang.StringBuilder, long], java.lang.StringBuilder), append/-1166366385=([java.lang.StringBuilder, char], java.lang.StringBuilder), arr-var3762-init=([], java.lang.Object[]), Int_valueOf/-1102777585=([long], java.lang.Long), cast-from-Int-to-var3762=([java.lang.Long], java.lang.Object), String_format/1339386452=([java.lang.String, java.lang.Object[]], java.lang.String), append/-1001720160=([java.lang.StringBuilder, int], java.lang.StringBuilder), getMessage/-1581253612=([org.apache.dubbo.common.profiler.ProfilerEntry], java.lang.String), toString/-2075883882=([java.lang.StringBuilder], java.lang.String), var457_add/328494887=([java.util.List, java.lang.Object], boolean), cast-from-var2770-to-var457=([java.util.LinkedList], java.util.List), cast-from-String-to-var3762=([java.lang.String], java.lang.Object), getSub/1235719092=([org.apache.dubbo.common.profiler.ProfilerEntry], java.util.List), var457_size/-959786421=([java.util.List], int)}
; {var1089=org.apache.dubbo.common.profiler.ProfilerEntry, var576=r1, var3248=l7, var1875=l3, var2847=i15, var3836=$r0, var2202=$l1, var3887=$l0, var173=l2, var1100=$l4, var867=$l5, var3930=i6, var3223=$l8, var1340=l9, var2770=java.util.LinkedList, var1856=$r2, var1819=$r3, var3519=$l10, var771=$r4, var1655=$r8, var3762=java.lang.Object, var643=$r5, var1269=$l11, var515=$r6, var1881=$r7, var76=$r9, var563=$r10, var2831=$l12, var3366=$r11, var1488=$r15, var1036=$r12, var1133=$l13, var1735=$r13, var1014=$r14, var3163=$r16, var2721=$r17, var1160=$r18, var3990=$r20, var503=$r19, var2809=$r21, var457=java.util.List, var3413=r22, var1918=i18, var1755=i14}
; {org.apache.dubbo.common.profiler.ProfilerEntry=var1089, r1=var576, l7=var3248, l3=var1875, i15=var2847, $r0=var3836, $l1=var2202, $l0=var3887, l2=var173, $l4=var1100, $l5=var867, i6=var3930, $l8=var3223, l9=var1340, java.util.LinkedList=var2770, $r2=var1856, $r3=var1819, $l10=var3519, $r4=var771, $r8=var1655, java.lang.Object=var3762, $r5=var643, $l11=var1269, $r6=var515, $r7=var1881, $r9=var76, $r10=var563, $l12=var2831, $r11=var3366, $r15=var1488, $r12=var1036, $l13=var1133, $r13=var1735, $r14=var1014, $r16=var3163, $r17=var2721, $r18=var1160, $r20=var3990, $r19=var503, $r21=var2809, java.util.List=var457, r22=var3413, i18=var1918, i14=var1755}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(long)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(char)>;	<java.lang.String: java.lang.String format(java.lang.String,java.lang.Object[])>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(long)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(char)>;	<java.lang.String: java.lang.String format(java.lang.String,java.lang.Object[])>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(int)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 7,"<java.lang.StringBuilder: java.lang.StringBuilder append(long)>": 2,"<java.lang.StringBuilder: java.lang.StringBuilder append(char)>": 2,"<java.lang.String: java.lang.String format(java.lang.String,java.lang.Object[])>": 2,"<java.lang.StringBuilder: java.lang.StringBuilder append(int)>": 1,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r1 := @parameter0: org.apache.dubbo.common.profiler.ProfilerEntry;	l7 := @parameter1: long;	l3 := @parameter2: long;	i15 := @parameter3: int;	$r0 = new java.lang.StringBuilder;	specialinvoke $r0.<java.lang.StringBuilder: void <init>()>();	$l1 = virtualinvoke r1.<org.apache.dubbo.common.profiler.ProfilerEntry: long getEndTime()>();	$l0 = virtualinvoke r1.<org.apache.dubbo.common.profiler.ProfilerEntry: long getStartTime()>();	l2 = $l1 - $l0;	$l4 = l2 * 100L;	$l5 = $l4 / l3;	i6 = (int) $l5;	$l8 = virtualinvoke r1.<org.apache.dubbo.common.profiler.ProfilerEntry: long getStartTime()>();	l9 = $l8 - l7;	$r2 = new java.util.LinkedList;	specialinvoke $r2.<java.util.LinkedList: void <init>()>();	$r3 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("+-[ Offset: ");	$l10 = l9 / 1000000L;	$r4 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(long)>($l10);	$r8 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(46);	$r5 = newarray (java.lang.Object)[1];	$l11 = l9 % 1000000L;	$r6 = staticinvoke <java.lang.Long: java.lang.Long valueOf(long)>($l11);	$r5[0] = $r6;	$r7 = staticinvoke <java.lang.String: java.lang.String format(java.lang.String,java.lang.Object[])>("%06d", $r5);	$r9 = virtualinvoke $r8.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r7);	$r10 = virtualinvoke $r9.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("ms; Usage: ");	$l12 = l2 / 1000000L;	$r11 = virtualinvoke $r10.<java.lang.StringBuilder: java.lang.StringBuilder append(long)>($l12);	$r15 = virtualinvoke $r11.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(46);	$r12 = newarray (java.lang.Object)[1];	$l13 = l2 % 1000000L;	$r13 = staticinvoke <java.lang.Long: java.lang.Long valueOf(long)>($l13);	$r12[0] = $r13;	$r14 = staticinvoke <java.lang.String: java.lang.String format(java.lang.String,java.lang.Object[])>("%06d", $r12);	$r16 = virtualinvoke $r15.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r14);	$r17 = virtualinvoke $r16.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("ms, ");	$r18 = virtualinvoke $r17.<java.lang.StringBuilder: java.lang.StringBuilder append(int)>(i6);	$r20 = virtualinvoke $r18.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("% ] ");	$r19 = virtualinvoke r1.<org.apache.dubbo.common.profiler.ProfilerEntry: java.lang.String getMessage()>();	virtualinvoke $r20.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r19);	$r21 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.String toString()>();	interfaceinvoke $r2.<java.util.List: boolean add(java.lang.Object)>($r21);	r22 = virtualinvoke r1.<org.apache.dubbo.common.profiler.ProfilerEntry: java.util.List getSub()>();	i18 = 0;	i14 = interfaceinvoke r22.<java.util.List: int size()>();	if i18 >= i14 goto return $r2;	return $r2
;block_num 3