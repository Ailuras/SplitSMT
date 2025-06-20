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

(declare-sort var3850 0)
(declare-sort var3973 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(define-fun length/-134980193 ((s String)) Int (str.len s))
(declare-fun String-init () String)
(declare-fun <init>/543593434 (String Int) void)
(declare-fun var3973_isNotEmpty/-1251449450 (String) Bool)
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(define-fun toString/-2075883882 ((s String)) String s)
(declare-const null-String String)
(declare-const var2868 String) ; Statement: r0 := @parameter0: java.lang.String 
(assert (not (= var2868 null-String)))
(declare-const var2728 String) ; Statement: r1 := @parameter1: java.lang.String 
(assert (not (= var2728 null-String)))
(declare-const var2817 String) ; Statement: r2 := @parameter2: java.lang.String 
(assert (not (= var2817 null-String)))
 ; Statement: if r0 != null goto $i3 = virtualinvoke r0.<java.lang.String: int length()>() 
(assert (not (= var2868 null-String))) ; Cond: r0 != null 
(assert true)
(define-const var1393 Int (length/-134980193 var2868)) ; Statement: $i3 = virtualinvoke r0.<java.lang.String: int length()>() 
(assert true) ; Non Conditional
(define-const var3611 Int var1393) ; Statement: $i1 = $i3 
 ; Statement: if r1 != null goto $i4 = virtualinvoke r1.<java.lang.String: int length()>() 
(assert (not (not (= var2728 null-String)))) ; Negate: Cond: r1 != null  
(define-const var2584 Int 0) ; Statement: $i4 = 0 
 ; Statement: goto [?= $i2 = $i1 + $i4] 
(assert true) ; Non Conditional
(define-const var934 Int (+ var3611 var2584)) ; Statement: $i2 = $i1 + $i4 
 ; Statement: if r2 != null goto $i5 = virtualinvoke r2.<java.lang.String: int length()>() 
(assert (not (not (= var2817 null-String)))) ; Negate: Cond: r2 != null  
(define-const var977 Int 0) ; Statement: $i5 = 0 
 ; Statement: goto [?= $i0 = $i2 + $i5] 
(assert true) ; Non Conditional
(define-const var3774 Int (+ var934 var977)) ; Statement: $i0 = $i2 + $i5 
(define-const var2316 Int (+ var3774 2)) ; Statement: i6 = $i0 + 2 
(define-const var1495 String String-init) ; Statement: $r3 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/543593434 var1495 var2316)) ; Statement: specialinvoke $r3.<java.lang.StringBuilder: void <init>(int)>(i6) 

(declare-const var1495!1 String)
(declare-const var2316!1 Int)
(define-const var3195 Bool (var3973_isNotEmpty/-1251449450 var2728)) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>(r1) 
 ; Statement: if $z0 == 0 goto virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r0) 
(assert (= (ite var3195 1 0) 0)) ; Cond: $z0 == 0 
(assert true)
;(assert (append/672562846 var1495!1 var2868)) ; Statement: virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r0) 
(declare-const var1495!2 String)
(assert (= var1495!2 (str.++ var1495!1 var2868)))
(define-const var3454 Bool (var3973_isNotEmpty/-1251449450 var2817)) ; Statement: $z1 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>(r2) 
 ; Statement: if $z1 == 0 goto $r4 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.String toString()>() 
(assert (= (ite var3454 1 0) 0)) ; Cond: $z1 == 0 
(assert true)
(define-const var703 String (toString/-2075883882 var1495!2)) ; Statement: $r4 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.String toString()>() 
 ; Statement: return $r4 
(check-sat)
; {length/-134980193=([java.lang.String], int), String-init=([], java.lang.StringBuilder), <init>/543593434=([java.lang.StringBuilder, int], void), var3973_isNotEmpty/-1251449450=([java.lang.String], boolean), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), toString/-2075883882=([java.lang.StringBuilder], java.lang.String)}
; {var2868=r0, var3850=null_type, var2728=r1, var2817=r2, var1393=$i3, var3611=$i1, var2584=$i4, var934=$i2, var977=$i5, var3774=$i0, var2316=i6, var1495=$r3, var3973=org.apache.dubbo.common.utils.StringUtils, var3195=$z0, var3454=$z1, var703=$r4}
; {r0=var2868, null_type=var3850, r1=var2728, r2=var2817, $i3=var1393, $i1=var3611, $i4=var2584, $i2=var934, $i5=var977, $i0=var3774, i6=var2316, $r3=var1495, org.apache.dubbo.common.utils.StringUtils=var3973, $z0=var3195, $z1=var3454, $r4=var703}
;seq <java.lang.String: int length()>;	<java.lang.StringBuilder: void <init>(int)>;	<org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.String: int length()>": 1,"<java.lang.StringBuilder: void <init>(int)>": 1,"<org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>": 2,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 1,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r0 := @parameter0: java.lang.String;	r1 := @parameter1: java.lang.String;	r2 := @parameter2: java.lang.String;	if r0 != null goto $i3 = virtualinvoke r0.<java.lang.String: int length()>();	$i3 = virtualinvoke r0.<java.lang.String: int length()>();	$i1 = $i3;	if r1 != null goto $i4 = virtualinvoke r1.<java.lang.String: int length()>();	$i4 = 0;	goto [?= $i2 = $i1 + $i4];	$i2 = $i1 + $i4;	if r2 != null goto $i5 = virtualinvoke r2.<java.lang.String: int length()>();	$i5 = 0;	goto [?= $i0 = $i2 + $i5];	$i0 = $i2 + $i5;	i6 = $i0 + 2;	$r3 = new java.lang.StringBuilder;	specialinvoke $r3.<java.lang.StringBuilder: void <init>(int)>(i6);	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>(r1);	if $z0 == 0 goto virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r0);	virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r0);	$z1 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>(r2);	if $z1 == 0 goto $r4 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.String toString()>();	$r4 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.String toString()>();	return $r4
;block_num 9