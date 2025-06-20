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

(declare-sort var3629 0)
(declare-sort var3157 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(define-fun length/-134980193 ((s String)) Int (str.len s))
(declare-fun String-init () String)
(declare-fun <init>/543593434 (String Int) void)
(declare-fun var3157_isNotEmpty/-1251449450 (String) Bool)
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(define-fun toString/-2075883882 ((s String)) String s)
(declare-const null-String String)
(declare-const var3737 String) ; Statement: r0 := @parameter0: java.lang.String 
(assert (not (= var3737 null-String)))
(declare-const var1553 String) ; Statement: r1 := @parameter1: java.lang.String 
(assert (not (= var1553 null-String)))
(declare-const var2792 String) ; Statement: r2 := @parameter2: java.lang.String 
(assert (not (= var2792 null-String)))
 ; Statement: if r0 != null goto $i3 = virtualinvoke r0.<java.lang.String: int length()>() 
(assert (not (not (= var3737 null-String)))) ; Negate: Cond: r0 != null  
(define-const var1135 Int 0) ; Statement: $i3 = 0 
 ; Statement: goto [?= $i1 = $i3] 
(assert true) ; Non Conditional
(define-const var686 Int var1135) ; Statement: $i1 = $i3 
 ; Statement: if r1 != null goto $i4 = virtualinvoke r1.<java.lang.String: int length()>() 
(assert (not (= var1553 null-String))) ; Cond: r1 != null 
(assert true)
(define-const var42 Int (length/-134980193 var1553)) ; Statement: $i4 = virtualinvoke r1.<java.lang.String: int length()>() 
(assert true) ; Non Conditional
(define-const var2356 Int (+ var686 var42)) ; Statement: $i2 = $i1 + $i4 
 ; Statement: if r2 != null goto $i5 = virtualinvoke r2.<java.lang.String: int length()>() 
(assert (not (not (= var2792 null-String)))) ; Negate: Cond: r2 != null  
(define-const var3655 Int 0) ; Statement: $i5 = 0 
 ; Statement: goto [?= $i0 = $i2 + $i5] 
(assert true) ; Non Conditional
(define-const var1734 Int (+ var2356 var3655)) ; Statement: $i0 = $i2 + $i5 
(define-const var861 Int (+ var1734 2)) ; Statement: i6 = $i0 + 2 
(define-const var1515 String String-init) ; Statement: $r3 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/543593434 var1515 var861)) ; Statement: specialinvoke $r3.<java.lang.StringBuilder: void <init>(int)>(i6) 

(declare-const var1515!1 String)
(declare-const var861!1 Int)
(define-const var2783 Bool (var3157_isNotEmpty/-1251449450 var1553)) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>(r1) 
 ; Statement: if $z0 == 0 goto virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r0) 
(assert (= (ite var2783 1 0) 0)) ; Cond: $z0 == 0 
(assert true)
;(assert (append/672562846 var1515!1 var3737)) ; Statement: virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r0) 
(declare-const var1515!2 String)
(assert (= var1515!2 (str.++ var1515!1 var3737)))
(define-const var3919 Bool (var3157_isNotEmpty/-1251449450 var2792)) ; Statement: $z1 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>(r2) 
 ; Statement: if $z1 == 0 goto $r4 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.String toString()>() 
(assert (= (ite var3919 1 0) 0)) ; Cond: $z1 == 0 
(assert true)
(define-const var3802 String (toString/-2075883882 var1515!2)) ; Statement: $r4 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.String toString()>() 
 ; Statement: return $r4 
(check-sat)
; {length/-134980193=([java.lang.String], int), String-init=([], java.lang.StringBuilder), <init>/543593434=([java.lang.StringBuilder, int], void), var3157_isNotEmpty/-1251449450=([java.lang.String], boolean), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), toString/-2075883882=([java.lang.StringBuilder], java.lang.String)}
; {var3737=r0, var3629=null_type, var1553=r1, var2792=r2, var1135=$i3, var686=$i1, var42=$i4, var2356=$i2, var3655=$i5, var1734=$i0, var861=i6, var1515=$r3, var3157=org.apache.dubbo.common.utils.StringUtils, var2783=$z0, var3919=$z1, var3802=$r4}
; {r0=var3737, null_type=var3629, r1=var1553, r2=var2792, $i3=var1135, $i1=var686, $i4=var42, $i2=var2356, $i5=var3655, $i0=var1734, i6=var861, $r3=var1515, org.apache.dubbo.common.utils.StringUtils=var3157, $z0=var2783, $z1=var3919, $r4=var3802}
;seq <java.lang.String: int length()>;	<java.lang.StringBuilder: void <init>(int)>;	<org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.String: int length()>": 1,"<java.lang.StringBuilder: void <init>(int)>": 1,"<org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>": 2,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 1,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r0 := @parameter0: java.lang.String;	r1 := @parameter1: java.lang.String;	r2 := @parameter2: java.lang.String;	if r0 != null goto $i3 = virtualinvoke r0.<java.lang.String: int length()>();	$i3 = 0;	goto [?= $i1 = $i3];	$i1 = $i3;	if r1 != null goto $i4 = virtualinvoke r1.<java.lang.String: int length()>();	$i4 = virtualinvoke r1.<java.lang.String: int length()>();	$i2 = $i1 + $i4;	if r2 != null goto $i5 = virtualinvoke r2.<java.lang.String: int length()>();	$i5 = 0;	goto [?= $i0 = $i2 + $i5];	$i0 = $i2 + $i5;	i6 = $i0 + 2;	$r3 = new java.lang.StringBuilder;	specialinvoke $r3.<java.lang.StringBuilder: void <init>(int)>(i6);	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>(r1);	if $z0 == 0 goto virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r0);	virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r0);	$z1 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>(r2);	if $z1 == 0 goto $r4 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.String toString()>();	$r4 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.String toString()>();	return $r4
;block_num 9