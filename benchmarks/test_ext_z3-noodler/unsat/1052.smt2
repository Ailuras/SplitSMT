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

(declare-sort var1150 0)
(declare-sort var681 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(define-fun length/-134980193 ((s String)) Int (str.len s))
(declare-fun String-init () String)
(declare-fun <init>/543593434 (String Int) void)
(declare-fun var681_isNotEmpty/-1251449450 (String) Bool)
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(define-fun toString/-2075883882 ((s String)) String s)
(declare-const null-String String)
(declare-const var2075 String) ; Statement: r0 := @parameter0: java.lang.String 
(assert (not (= var2075 null-String)))
(declare-const var555 String) ; Statement: r1 := @parameter1: java.lang.String 
(assert (not (= var555 null-String)))
(declare-const var3543 String) ; Statement: r2 := @parameter2: java.lang.String 
(assert (not (= var3543 null-String)))
 ; Statement: if r0 != null goto $i3 = virtualinvoke r0.<java.lang.String: int length()>() 
(assert (not (= var2075 null-String))) ; Cond: r0 != null 
(assert true)
(define-const var3195 Int (length/-134980193 var2075)) ; Statement: $i3 = virtualinvoke r0.<java.lang.String: int length()>() 
(assert true) ; Non Conditional
(define-const var40 Int var3195) ; Statement: $i1 = $i3 
 ; Statement: if r1 != null goto $i4 = virtualinvoke r1.<java.lang.String: int length()>() 
(assert (not (not (= var555 null-String)))) ; Negate: Cond: r1 != null  
(define-const var2842 Int 0) ; Statement: $i4 = 0 
 ; Statement: goto [?= $i2 = $i1 + $i4] 
(assert true) ; Non Conditional
(define-const var2446 Int (+ var40 var2842)) ; Statement: $i2 = $i1 + $i4 
 ; Statement: if r2 != null goto $i5 = virtualinvoke r2.<java.lang.String: int length()>() 
(assert (not (= var3543 null-String))) ; Cond: r2 != null 
(assert true)
(define-const var261 Int (length/-134980193 var3543)) ; Statement: $i5 = virtualinvoke r2.<java.lang.String: int length()>() 
(assert true) ; Non Conditional
(define-const var1077 Int (+ var2446 var261)) ; Statement: $i0 = $i2 + $i5 
(define-const var2387 Int (+ var1077 2)) ; Statement: i6 = $i0 + 2 
(define-const var2636 String String-init) ; Statement: $r3 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/543593434 var2636 var2387)) ; Statement: specialinvoke $r3.<java.lang.StringBuilder: void <init>(int)>(i6) 

(declare-const var2636!1 String)
(declare-const var2387!1 Int)
(define-const var2578 Bool (var681_isNotEmpty/-1251449450 var555)) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>(r1) 
 ; Statement: if $z0 == 0 goto virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r0) 
(assert (= (ite var2578 1 0) 0)) ; Cond: $z0 == 0 
(assert true)
;(assert (append/672562846 var2636!1 var2075)) ; Statement: virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r0) 
(declare-const var2636!2 String)
(assert (= var2636!2 (str.++ var2636!1 var2075)))
(define-const var1309 Bool (var681_isNotEmpty/-1251449450 var3543)) ; Statement: $z1 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>(r2) 
 ; Statement: if $z1 == 0 goto $r4 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.String toString()>() 
(assert (= (ite var1309 1 0) 0)) ; Cond: $z1 == 0 
(assert true)
(define-const var1548 String (toString/-2075883882 var2636!2)) ; Statement: $r4 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.String toString()>() 
 ; Statement: return $r4 
(check-sat)
; {length/-134980193=([java.lang.String], int), String-init=([], java.lang.StringBuilder), <init>/543593434=([java.lang.StringBuilder, int], void), var681_isNotEmpty/-1251449450=([java.lang.String], boolean), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), toString/-2075883882=([java.lang.StringBuilder], java.lang.String)}
; {var2075=r0, var1150=null_type, var555=r1, var3543=r2, var3195=$i3, var40=$i1, var2842=$i4, var2446=$i2, var261=$i5, var1077=$i0, var2387=i6, var2636=$r3, var681=org.apache.dubbo.common.utils.StringUtils, var2578=$z0, var1309=$z1, var1548=$r4}
; {r0=var2075, null_type=var1150, r1=var555, r2=var3543, $i3=var3195, $i1=var40, $i4=var2842, $i2=var2446, $i5=var261, $i0=var1077, i6=var2387, $r3=var2636, org.apache.dubbo.common.utils.StringUtils=var681, $z0=var2578, $z1=var1309, $r4=var1548}
;seq <java.lang.String: int length()>;	<java.lang.String: int length()>;	<java.lang.StringBuilder: void <init>(int)>;	<org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.String: int length()>": 2,"<java.lang.StringBuilder: void <init>(int)>": 1,"<org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>": 2,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 1,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r0 := @parameter0: java.lang.String;	r1 := @parameter1: java.lang.String;	r2 := @parameter2: java.lang.String;	if r0 != null goto $i3 = virtualinvoke r0.<java.lang.String: int length()>();	$i3 = virtualinvoke r0.<java.lang.String: int length()>();	$i1 = $i3;	if r1 != null goto $i4 = virtualinvoke r1.<java.lang.String: int length()>();	$i4 = 0;	goto [?= $i2 = $i1 + $i4];	$i2 = $i1 + $i4;	if r2 != null goto $i5 = virtualinvoke r2.<java.lang.String: int length()>();	$i5 = virtualinvoke r2.<java.lang.String: int length()>();	$i0 = $i2 + $i5;	i6 = $i0 + 2;	$r3 = new java.lang.StringBuilder;	specialinvoke $r3.<java.lang.StringBuilder: void <init>(int)>(i6);	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>(r1);	if $z0 == 0 goto virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r0);	virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r0);	$z1 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>(r2);	if $z1 == 0 goto $r4 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.String toString()>();	$r4 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.String toString()>();	return $r4
;block_num 9