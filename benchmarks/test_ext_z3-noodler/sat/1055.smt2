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

(declare-sort var3373 0)
(declare-sort var3882 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(define-fun length/-134980193 ((s String)) Int (str.len s))
(declare-fun String-init () String)
(declare-fun <init>/543593434 (String Int) void)
(declare-fun var3882_isNotEmpty/-1251449450 (String) Bool)
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(define-fun toString/-2075883882 ((s String)) String s)
(declare-const null-String String)
(declare-const var1084 String) ; Statement: r0 := @parameter0: java.lang.String 
(assert (not (= var1084 null-String)))
(declare-const var3116 String) ; Statement: r1 := @parameter1: java.lang.String 
(assert (not (= var3116 null-String)))
(declare-const var2932 String) ; Statement: r2 := @parameter2: java.lang.String 
(assert (not (= var2932 null-String)))
 ; Statement: if r0 != null goto $i3 = virtualinvoke r0.<java.lang.String: int length()>() 
(assert (not (= var1084 null-String))) ; Cond: r0 != null 
(assert true)
(define-const var1824 Int (length/-134980193 var1084)) ; Statement: $i3 = virtualinvoke r0.<java.lang.String: int length()>() 
(assert true) ; Non Conditional
(define-const var1014 Int var1824) ; Statement: $i1 = $i3 
 ; Statement: if r1 != null goto $i4 = virtualinvoke r1.<java.lang.String: int length()>() 
(assert (not (= var3116 null-String))) ; Cond: r1 != null 
(assert true)
(define-const var341 Int (length/-134980193 var3116)) ; Statement: $i4 = virtualinvoke r1.<java.lang.String: int length()>() 
(assert true) ; Non Conditional
(define-const var752 Int (+ var1014 var341)) ; Statement: $i2 = $i1 + $i4 
 ; Statement: if r2 != null goto $i5 = virtualinvoke r2.<java.lang.String: int length()>() 
(assert (not (= var2932 null-String))) ; Cond: r2 != null 
(assert true)
(define-const var3841 Int (length/-134980193 var2932)) ; Statement: $i5 = virtualinvoke r2.<java.lang.String: int length()>() 
(assert true) ; Non Conditional
(define-const var3444 Int (+ var752 var3841)) ; Statement: $i0 = $i2 + $i5 
(define-const var3006 Int (+ var3444 2)) ; Statement: i6 = $i0 + 2 
(define-const var2523 String String-init) ; Statement: $r3 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/543593434 var2523 var3006)) ; Statement: specialinvoke $r3.<java.lang.StringBuilder: void <init>(int)>(i6) 

(declare-const var2523!1 String)
(declare-const var3006!1 Int)
(define-const var1116 Bool (var3882_isNotEmpty/-1251449450 var3116)) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>(r1) 
 ; Statement: if $z0 == 0 goto virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r0) 
(assert (= (ite var1116 1 0) 0)) ; Cond: $z0 == 0 
(assert true)
;(assert (append/672562846 var2523!1 var1084)) ; Statement: virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r0) 
(declare-const var2523!2 String)
(assert (= var2523!2 (str.++ var2523!1 var1084)))
(define-const var3952 Bool (var3882_isNotEmpty/-1251449450 var2932)) ; Statement: $z1 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>(r2) 
 ; Statement: if $z1 == 0 goto $r4 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.String toString()>() 
(assert (= (ite var3952 1 0) 0)) ; Cond: $z1 == 0 
(assert true)
(define-const var3497 String (toString/-2075883882 var2523!2)) ; Statement: $r4 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.String toString()>() 
 ; Statement: return $r4 
(check-sat)
; {length/-134980193=([java.lang.String], int), String-init=([], java.lang.StringBuilder), <init>/543593434=([java.lang.StringBuilder, int], void), var3882_isNotEmpty/-1251449450=([java.lang.String], boolean), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), toString/-2075883882=([java.lang.StringBuilder], java.lang.String)}
; {var1084=r0, var3373=null_type, var3116=r1, var2932=r2, var1824=$i3, var1014=$i1, var341=$i4, var752=$i2, var3841=$i5, var3444=$i0, var3006=i6, var2523=$r3, var3882=org.apache.dubbo.common.utils.StringUtils, var1116=$z0, var3952=$z1, var3497=$r4}
; {r0=var1084, null_type=var3373, r1=var3116, r2=var2932, $i3=var1824, $i1=var1014, $i4=var341, $i2=var752, $i5=var3841, $i0=var3444, i6=var3006, $r3=var2523, org.apache.dubbo.common.utils.StringUtils=var3882, $z0=var1116, $z1=var3952, $r4=var3497}
;seq <java.lang.String: int length()>;	<java.lang.String: int length()>;	<java.lang.String: int length()>;	<java.lang.StringBuilder: void <init>(int)>;	<org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.String: int length()>": 3,"<java.lang.StringBuilder: void <init>(int)>": 1,"<org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>": 2,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 1,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r0 := @parameter0: java.lang.String;	r1 := @parameter1: java.lang.String;	r2 := @parameter2: java.lang.String;	if r0 != null goto $i3 = virtualinvoke r0.<java.lang.String: int length()>();	$i3 = virtualinvoke r0.<java.lang.String: int length()>();	$i1 = $i3;	if r1 != null goto $i4 = virtualinvoke r1.<java.lang.String: int length()>();	$i4 = virtualinvoke r1.<java.lang.String: int length()>();	$i2 = $i1 + $i4;	if r2 != null goto $i5 = virtualinvoke r2.<java.lang.String: int length()>();	$i5 = virtualinvoke r2.<java.lang.String: int length()>();	$i0 = $i2 + $i5;	i6 = $i0 + 2;	$r3 = new java.lang.StringBuilder;	specialinvoke $r3.<java.lang.StringBuilder: void <init>(int)>(i6);	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>(r1);	if $z0 == 0 goto virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r0);	virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r0);	$z1 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>(r2);	if $z1 == 0 goto $r4 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.String toString()>();	$r4 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.String toString()>();	return $r4
;block_num 9