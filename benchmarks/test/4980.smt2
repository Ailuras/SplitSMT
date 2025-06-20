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

(declare-sort var2634 0)
(declare-sort var2058 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(define-fun indexOf/-1037706067 ((s String) (c Int)) Int (str.indexof s (str.from_code c) 0))
(declare-fun lastIndexOf/-1292097097 (String Int) Int)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(define-fun toString/-2075883882 ((s String)) String s)
(declare-fun var2058_valueOf/-778994652 (String) var2058)
(declare-const null-String String)
(declare-const var3608 String) ; Statement: r18 := @parameter0: java.lang.String 
(assert (not (= var3608 null-String)))
(declare-const var444 String) ; Statement: r5 := @parameter1: java.lang.String 
(assert (not (= var444 null-String)))
(define-const var1444 String null-String) ; Statement: r19 = null 
(define-const var213 String null-String) ; Statement: r20 = null 
(assert true)
(define-const var1788 Int (indexOf/-1037706067 var3608 47)) ; Statement: i3 = virtualinvoke r18.<java.lang.String: int indexOf(int)>(47) 
 ; Statement: if i3 <= 0 goto $i2 = virtualinvoke r18.<java.lang.String: int lastIndexOf(int)>(58) 
(assert (<= var1788 0)) ; Cond: i3 <= 0 
(assert true)
(define-const var193 Int (lastIndexOf/-1292097097 var3608 58)) ; Statement: $i2 = virtualinvoke r18.<java.lang.String: int lastIndexOf(int)>(58) 
 ; Statement: if $i2 <= 0 goto $r0 = new java.lang.StringBuilder 
(assert (<= var193 0)) ; Cond: $i2 <= 0 
(define-const var2704 String String-init) ; Statement: $r0 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var2704)) ; Statement: specialinvoke $r0.<java.lang.StringBuilder: void <init>()>() 
(declare-const var2704!1 String)
(assert (= var2704!1 ""))
(assert true)
(define-const var3251 String (append/672562846 var2704!1 "empty://0.0.0.0/")) ; Statement: $r1 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("empty://0.0.0.0/") 
(declare-const var2704!2 String)
(assert (= var2704!2 (str.++ var2704!1 "empty://0.0.0.0/")))
(assert true)
(define-const var3298 String (append/672562846 var3251 var3608)) ; Statement: $r2 = virtualinvoke $r1.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r18) 
(declare-const var3251!1 String)
(assert (= var3251!1 (str.++ var3251 var3608)))
(assert true)
(define-const var1218 String (append/672562846 var3298 "?")) ; Statement: $r3 = virtualinvoke $r2.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("?") 
(declare-const var3298!1 String)
(assert (= var3298!1 (str.++ var3298 "?")))
(assert true)
(define-const var2971 String (append/672562846 var1218 "category")) ; Statement: $r4 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("category") 
(declare-const var1218!1 String)
(assert (= var1218!1 (str.++ var1218 "category")))
(assert true)
(define-const var3092 String (append/672562846 var2971 "=")) ; Statement: $r6 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("=") 
(declare-const var2971!1 String)
(assert (= var2971!1 (str.++ var2971 "=")))
(assert true)
(define-const var490 String (append/672562846 var3092 var444)) ; Statement: $r10 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r5) 
(declare-const var3092!1 String)
(assert (= var3092!1 (str.++ var3092 var444)))
 ; Statement: if r19 != null goto $r7 = new java.lang.StringBuilder 
(assert (not (= var1444 null-String))) ; Cond: r19 != null 
(define-const var1462 String String-init) ; Statement: $r7 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var1462)) ; Statement: specialinvoke $r7.<java.lang.StringBuilder: void <init>()>() 
(declare-const var1462!1 String)
(assert (= var1462!1 ""))
(assert true)
(define-const var2009 String (append/672562846 var1462!1 "&group=")) ; Statement: $r8 = virtualinvoke $r7.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("&group=") 
(declare-const var1462!2 String)
(assert (= var1462!2 (str.++ var1462!1 "&group=")))
(assert true)
(define-const var1361 String (append/672562846 var2009 var1444)) ; Statement: $r9 = virtualinvoke $r8.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r19) 
(declare-const var2009!1 String)
(assert (= var2009!1 (str.++ var2009 var1444)))
(assert true)
(define-const var2001 String (toString/-2075883882 var1361)) ; Statement: $r21 = virtualinvoke $r9.<java.lang.StringBuilder: java.lang.String toString()>() 
(assert true) ; Non Conditional
(assert true)
(define-const var623 String (append/672562846 var490 var2001)) ; Statement: $r14 = virtualinvoke $r10.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r21) 
(declare-const var490!1 String)
(assert (= var490!1 (str.++ var490 var2001)))
 ; Statement: if r20 != null goto $r11 = new java.lang.StringBuilder 
(assert (not (= var213 null-String))) ; Cond: r20 != null 
(define-const var255 String String-init) ; Statement: $r11 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var255)) ; Statement: specialinvoke $r11.<java.lang.StringBuilder: void <init>()>() 
(declare-const var255!1 String)
(assert (= var255!1 ""))
(assert true)
(define-const var3683 String (append/672562846 var255!1 "&version=")) ; Statement: $r12 = virtualinvoke $r11.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("&version=") 
(declare-const var255!2 String)
(assert (= var255!2 (str.++ var255!1 "&version=")))
(assert true)
(define-const var2786 String (append/672562846 var3683 var213)) ; Statement: $r13 = virtualinvoke $r12.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r20) 
(declare-const var3683!1 String)
(assert (= var3683!1 (str.++ var3683 var213)))
(assert true)
(define-const var2047 String (toString/-2075883882 var2786)) ; Statement: $r22 = virtualinvoke $r13.<java.lang.StringBuilder: java.lang.String toString()>() 
(assert true) ; Non Conditional
(assert true)
(define-const var1074 String (append/672562846 var623 var2047)) ; Statement: $r15 = virtualinvoke $r14.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r22) 
(declare-const var623!1 String)
(assert (= var623!1 (str.++ var623 var2047)))
(assert true)
(define-const var2725 String (toString/-2075883882 var1074)) ; Statement: $r16 = virtualinvoke $r15.<java.lang.StringBuilder: java.lang.String toString()>() 
(define-const var702 var2058 (var2058_valueOf/-778994652 var2725)) ; Statement: $r17 = staticinvoke <org.apache.dubbo.common.URL: org.apache.dubbo.common.URL valueOf(java.lang.String)>($r16) 
 ; Statement: return $r17 
(check-sat)
; {indexOf/-1037706067=([java.lang.String, int], int), lastIndexOf/-1292097097=([java.lang.String, int], int), String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), toString/-2075883882=([java.lang.StringBuilder], java.lang.String), var2058_valueOf/-778994652=([java.lang.String], org.apache.dubbo.common.URL)}
; {var3608=r18, var2634=null_type, var444=r5, var1444=r19, var213=r20, var1788=i3, var193=$i2, var2704=$r0, var3251=$r1, var3298=$r2, var1218=$r3, var2971=$r4, var3092=$r6, var490=$r10, var1462=$r7, var2009=$r8, var1361=$r9, var2001=$r21, var623=$r14, var255=$r11, var3683=$r12, var2786=$r13, var2047=$r22, var1074=$r15, var2725=$r16, var2058=org.apache.dubbo.common.URL, var702=$r17}
; {r18=var3608, null_type=var2634, r5=var444, r19=var1444, r20=var213, i3=var1788, $i2=var193, $r0=var2704, $r1=var3251, $r2=var3298, $r3=var1218, $r4=var2971, $r6=var3092, $r10=var490, $r7=var1462, $r8=var2009, $r9=var1361, $r21=var2001, $r14=var623, $r11=var255, $r12=var3683, $r13=var2786, $r22=var2047, $r15=var1074, $r16=var2725, org.apache.dubbo.common.URL=var2058, $r17=var702}
;seq <java.lang.String: int indexOf(int)>;	<java.lang.String: int lastIndexOf(int)>;	<java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.String: int indexOf(int)>": 1,"<java.lang.String: int lastIndexOf(int)>": 1,"<java.lang.StringBuilder: void <init>()>": 3,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 12,"<java.lang.StringBuilder: java.lang.String toString()>": 3}
;stmts r18 := @parameter0: java.lang.String;	r5 := @parameter1: java.lang.String;	r19 = null;	r20 = null;	i3 = virtualinvoke r18.<java.lang.String: int indexOf(int)>(47);	if i3 <= 0 goto $i2 = virtualinvoke r18.<java.lang.String: int lastIndexOf(int)>(58);	$i2 = virtualinvoke r18.<java.lang.String: int lastIndexOf(int)>(58);	if $i2 <= 0 goto $r0 = new java.lang.StringBuilder;	$r0 = new java.lang.StringBuilder;	specialinvoke $r0.<java.lang.StringBuilder: void <init>()>();	$r1 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("empty://0.0.0.0/");	$r2 = virtualinvoke $r1.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r18);	$r3 = virtualinvoke $r2.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("?");	$r4 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("category");	$r6 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("=");	$r10 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r5);	if r19 != null goto $r7 = new java.lang.StringBuilder;	$r7 = new java.lang.StringBuilder;	specialinvoke $r7.<java.lang.StringBuilder: void <init>()>();	$r8 = virtualinvoke $r7.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("&group=");	$r9 = virtualinvoke $r8.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r19);	$r21 = virtualinvoke $r9.<java.lang.StringBuilder: java.lang.String toString()>();	$r14 = virtualinvoke $r10.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r21);	if r20 != null goto $r11 = new java.lang.StringBuilder;	$r11 = new java.lang.StringBuilder;	specialinvoke $r11.<java.lang.StringBuilder: void <init>()>();	$r12 = virtualinvoke $r11.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("&version=");	$r13 = virtualinvoke $r12.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r20);	$r22 = virtualinvoke $r13.<java.lang.StringBuilder: java.lang.String toString()>();	$r15 = virtualinvoke $r14.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r22);	$r16 = virtualinvoke $r15.<java.lang.StringBuilder: java.lang.String toString()>();	$r17 = staticinvoke <org.apache.dubbo.common.URL: org.apache.dubbo.common.URL valueOf(java.lang.String)>($r16);	return $r17
;block_num 7