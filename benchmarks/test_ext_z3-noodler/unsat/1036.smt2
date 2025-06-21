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

(declare-sort var2600 0)
(declare-sort var1468 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(define-fun length/-134980193 ((s String)) Int (str.len s))
(declare-fun String-init () String)
(declare-fun <init>/543593434 (String Int) void)
(declare-fun var1468_isNotEmpty/-1251449450 (String) Bool)
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(define-fun toString/-2075883882 ((s String)) String s)
(declare-const null-String String)
(declare-const var3470 String) ; Statement: r0 := @parameter0: java.lang.String 
(assert (not (= var3470 null-String)))
(declare-const var3078 String) ; Statement: r1 := @parameter1: java.lang.String 
(assert (not (= var3078 null-String)))
(declare-const var2669 String) ; Statement: r2 := @parameter2: java.lang.String 
(assert (not (= var2669 null-String)))
 ; Statement: if r0 != null goto $i3 = virtualinvoke r0.<java.lang.String: int length()>() 
(assert (not (not (= var3470 null-String)))) ; Negate: Cond: r0 != null  
(define-const var1022 Int 0) ; Statement: $i3 = 0 
 ; Statement: goto [?= $i1 = $i3] 
(assert true) ; Non Conditional
(define-const var2943 Int var1022) ; Statement: $i1 = $i3 
 ; Statement: if r1 != null goto $i4 = virtualinvoke r1.<java.lang.String: int length()>() 
(assert (not (= var3078 null-String))) ; Cond: r1 != null 
(assert true)
(define-const var2276 Int (length/-134980193 var3078)) ; Statement: $i4 = virtualinvoke r1.<java.lang.String: int length()>() 
(assert true) ; Non Conditional
(define-const var3068 Int (+ var2943 var2276)) ; Statement: $i2 = $i1 + $i4 
 ; Statement: if r2 != null goto $i5 = virtualinvoke r2.<java.lang.String: int length()>() 
(assert (not (= var2669 null-String))) ; Cond: r2 != null 
(assert true)
(define-const var2071 Int (length/-134980193 var2669)) ; Statement: $i5 = virtualinvoke r2.<java.lang.String: int length()>() 
(assert true) ; Non Conditional
(define-const var3695 Int (+ var3068 var2071)) ; Statement: $i0 = $i2 + $i5 
(define-const var2818 Int (+ var3695 2)) ; Statement: i6 = $i0 + 2 
(define-const var1086 String String-init) ; Statement: $r3 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/543593434 var1086 var2818)) ; Statement: specialinvoke $r3.<java.lang.StringBuilder: void <init>(int)>(i6) 

(declare-const var1086!1 String)
(declare-const var2818!1 Int)
(define-const var3651 Bool (var1468_isNotEmpty/-1251449450 var3078)) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>(r1) 
 ; Statement: if $z0 == 0 goto virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r0) 
(assert (= (ite var3651 1 0) 0)) ; Cond: $z0 == 0 
(assert true)
;(assert (append/672562846 var1086!1 var3470)) ; Statement: virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r0) 
(declare-const var1086!2 String)
(assert (= var1086!2 (str.++ var1086!1 var3470)))
(define-const var745 Bool (var1468_isNotEmpty/-1251449450 var2669)) ; Statement: $z1 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>(r2) 
 ; Statement: if $z1 == 0 goto $r4 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.String toString()>() 
(assert (= (ite var745 1 0) 0)) ; Cond: $z1 == 0 
(assert true)
(define-const var313 String (toString/-2075883882 var1086!2)) ; Statement: $r4 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.String toString()>() 
 ; Statement: return $r4 
(check-sat)
; {length/-134980193=([java.lang.String], int), String-init=([], java.lang.StringBuilder), <init>/543593434=([java.lang.StringBuilder, int], void), var1468_isNotEmpty/-1251449450=([java.lang.String], boolean), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), toString/-2075883882=([java.lang.StringBuilder], java.lang.String)}
; {var3470=r0, var2600=null_type, var3078=r1, var2669=r2, var1022=$i3, var2943=$i1, var2276=$i4, var3068=$i2, var2071=$i5, var3695=$i0, var2818=i6, var1086=$r3, var1468=org.apache.dubbo.common.utils.StringUtils, var3651=$z0, var745=$z1, var313=$r4}
; {r0=var3470, null_type=var2600, r1=var3078, r2=var2669, $i3=var1022, $i1=var2943, $i4=var2276, $i2=var3068, $i5=var2071, $i0=var3695, i6=var2818, $r3=var1086, org.apache.dubbo.common.utils.StringUtils=var1468, $z0=var3651, $z1=var745, $r4=var313}
;seq <java.lang.String: int length()>;	<java.lang.String: int length()>;	<java.lang.StringBuilder: void <init>(int)>;	<org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.String: int length()>": 2,"<java.lang.StringBuilder: void <init>(int)>": 1,"<org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>": 2,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 1,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r0 := @parameter0: java.lang.String;	r1 := @parameter1: java.lang.String;	r2 := @parameter2: java.lang.String;	if r0 != null goto $i3 = virtualinvoke r0.<java.lang.String: int length()>();	$i3 = 0;	goto [?= $i1 = $i3];	$i1 = $i3;	if r1 != null goto $i4 = virtualinvoke r1.<java.lang.String: int length()>();	$i4 = virtualinvoke r1.<java.lang.String: int length()>();	$i2 = $i1 + $i4;	if r2 != null goto $i5 = virtualinvoke r2.<java.lang.String: int length()>();	$i5 = virtualinvoke r2.<java.lang.String: int length()>();	$i0 = $i2 + $i5;	i6 = $i0 + 2;	$r3 = new java.lang.StringBuilder;	specialinvoke $r3.<java.lang.StringBuilder: void <init>(int)>(i6);	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>(r1);	if $z0 == 0 goto virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r0);	virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r0);	$z1 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>(r2);	if $z1 == 0 goto $r4 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.String toString()>();	$r4 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.String toString()>();	return $r4
;block_num 9