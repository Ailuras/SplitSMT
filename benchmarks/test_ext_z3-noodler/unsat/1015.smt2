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

(declare-sort var645 0)
(declare-sort var3438 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(define-fun length/-134980193 ((s String)) Int (str.len s))
(declare-fun String-init () String)
(declare-fun <init>/543593434 (String Int) void)
(declare-fun var3438_isNotEmpty/-1251449450 (String) Bool)
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(define-fun toString/-2075883882 ((s String)) String s)
(declare-const null-String String)
(declare-const var47 String) ; Statement: r0 := @parameter0: java.lang.String 
(assert (not (= var47 null-String)))
(declare-const var86 String) ; Statement: r1 := @parameter1: java.lang.String 
(assert (not (= var86 null-String)))
(declare-const var1567 String) ; Statement: r2 := @parameter2: java.lang.String 
(assert (not (= var1567 null-String)))
 ; Statement: if r0 != null goto $i3 = virtualinvoke r0.<java.lang.String: int length()>() 
(assert (not (not (= var47 null-String)))) ; Negate: Cond: r0 != null  
(define-const var1697 Int 0) ; Statement: $i3 = 0 
 ; Statement: goto [?= $i1 = $i3] 
(assert true) ; Non Conditional
(define-const var2102 Int var1697) ; Statement: $i1 = $i3 
 ; Statement: if r1 != null goto $i4 = virtualinvoke r1.<java.lang.String: int length()>() 
(assert (not (not (= var86 null-String)))) ; Negate: Cond: r1 != null  
(define-const var2073 Int 0) ; Statement: $i4 = 0 
 ; Statement: goto [?= $i2 = $i1 + $i4] 
(assert true) ; Non Conditional
(define-const var183 Int (+ var2102 var2073)) ; Statement: $i2 = $i1 + $i4 
 ; Statement: if r2 != null goto $i5 = virtualinvoke r2.<java.lang.String: int length()>() 
(assert (not (= var1567 null-String))) ; Cond: r2 != null 
(assert true)
(define-const var3068 Int (length/-134980193 var1567)) ; Statement: $i5 = virtualinvoke r2.<java.lang.String: int length()>() 
(assert true) ; Non Conditional
(define-const var3850 Int (+ var183 var3068)) ; Statement: $i0 = $i2 + $i5 
(define-const var482 Int (+ var3850 2)) ; Statement: i6 = $i0 + 2 
(define-const var2710 String String-init) ; Statement: $r3 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/543593434 var2710 var482)) ; Statement: specialinvoke $r3.<java.lang.StringBuilder: void <init>(int)>(i6) 

(declare-const var2710!1 String)
(declare-const var482!1 Int)
(define-const var202 Bool (var3438_isNotEmpty/-1251449450 var86)) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>(r1) 
 ; Statement: if $z0 == 0 goto virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r0) 
(assert (= (ite var202 1 0) 0)) ; Cond: $z0 == 0 
(assert true)
;(assert (append/672562846 var2710!1 var47)) ; Statement: virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r0) 
(declare-const var2710!2 String)
(assert (= var2710!2 (str.++ var2710!1 var47)))
(define-const var994 Bool (var3438_isNotEmpty/-1251449450 var1567)) ; Statement: $z1 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>(r2) 
 ; Statement: if $z1 == 0 goto $r4 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.String toString()>() 
(assert (= (ite var994 1 0) 0)) ; Cond: $z1 == 0 
(assert true)
(define-const var1050 String (toString/-2075883882 var2710!2)) ; Statement: $r4 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.String toString()>() 
 ; Statement: return $r4 
(check-sat)
; {length/-134980193=([java.lang.String], int), String-init=([], java.lang.StringBuilder), <init>/543593434=([java.lang.StringBuilder, int], void), var3438_isNotEmpty/-1251449450=([java.lang.String], boolean), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), toString/-2075883882=([java.lang.StringBuilder], java.lang.String)}
; {var47=r0, var645=null_type, var86=r1, var1567=r2, var1697=$i3, var2102=$i1, var2073=$i4, var183=$i2, var3068=$i5, var3850=$i0, var482=i6, var2710=$r3, var3438=org.apache.dubbo.common.utils.StringUtils, var202=$z0, var994=$z1, var1050=$r4}
; {r0=var47, null_type=var645, r1=var86, r2=var1567, $i3=var1697, $i1=var2102, $i4=var2073, $i2=var183, $i5=var3068, $i0=var3850, i6=var482, $r3=var2710, org.apache.dubbo.common.utils.StringUtils=var3438, $z0=var202, $z1=var994, $r4=var1050}
;seq <java.lang.String: int length()>;	<java.lang.StringBuilder: void <init>(int)>;	<org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.String: int length()>": 1,"<java.lang.StringBuilder: void <init>(int)>": 1,"<org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>": 2,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 1,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r0 := @parameter0: java.lang.String;	r1 := @parameter1: java.lang.String;	r2 := @parameter2: java.lang.String;	if r0 != null goto $i3 = virtualinvoke r0.<java.lang.String: int length()>();	$i3 = 0;	goto [?= $i1 = $i3];	$i1 = $i3;	if r1 != null goto $i4 = virtualinvoke r1.<java.lang.String: int length()>();	$i4 = 0;	goto [?= $i2 = $i1 + $i4];	$i2 = $i1 + $i4;	if r2 != null goto $i5 = virtualinvoke r2.<java.lang.String: int length()>();	$i5 = virtualinvoke r2.<java.lang.String: int length()>();	$i0 = $i2 + $i5;	i6 = $i0 + 2;	$r3 = new java.lang.StringBuilder;	specialinvoke $r3.<java.lang.StringBuilder: void <init>(int)>(i6);	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>(r1);	if $z0 == 0 goto virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r0);	virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r0);	$z1 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>(r2);	if $z1 == 0 goto $r4 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.String toString()>();	$r4 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.String toString()>();	return $r4
;block_num 9