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

(declare-sort var2641 0)
(declare-sort var2706 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun String-init () String)
(declare-fun <init>/543593434 (String Int) void)
(declare-fun var2706_isNotEmpty/-1251449450 (String) Bool)
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(define-fun toString/-2075883882 ((s String)) String s)
(declare-const null-String String)
(declare-const var1976 String) ; Statement: r0 := @parameter0: java.lang.String 
(assert (not (= var1976 null-String)))
(declare-const var1358 String) ; Statement: r1 := @parameter1: java.lang.String 
(assert (not (= var1358 null-String)))
(declare-const var2231 String) ; Statement: r2 := @parameter2: java.lang.String 
(assert (not (= var2231 null-String)))
 ; Statement: if r0 != null goto $i3 = virtualinvoke r0.<java.lang.String: int length()>() 
(assert (not (not (= var1976 null-String)))) ; Negate: Cond: r0 != null  
(define-const var3972 Int 0) ; Statement: $i3 = 0 
 ; Statement: goto [?= $i1 = $i3] 
(assert true) ; Non Conditional
(define-const var3047 Int var3972) ; Statement: $i1 = $i3 
 ; Statement: if r1 != null goto $i4 = virtualinvoke r1.<java.lang.String: int length()>() 
(assert (not (not (= var1358 null-String)))) ; Negate: Cond: r1 != null  
(define-const var2307 Int 0) ; Statement: $i4 = 0 
 ; Statement: goto [?= $i2 = $i1 + $i4] 
(assert true) ; Non Conditional
(define-const var2468 Int (+ var3047 var2307)) ; Statement: $i2 = $i1 + $i4 
 ; Statement: if r2 != null goto $i5 = virtualinvoke r2.<java.lang.String: int length()>() 
(assert (not (not (= var2231 null-String)))) ; Negate: Cond: r2 != null  
(define-const var3081 Int 0) ; Statement: $i5 = 0 
 ; Statement: goto [?= $i0 = $i2 + $i5] 
(assert true) ; Non Conditional
(define-const var2414 Int (+ var2468 var3081)) ; Statement: $i0 = $i2 + $i5 
(define-const var1325 Int (+ var2414 2)) ; Statement: i6 = $i0 + 2 
(define-const var2300 String String-init) ; Statement: $r3 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/543593434 var2300 var1325)) ; Statement: specialinvoke $r3.<java.lang.StringBuilder: void <init>(int)>(i6) 

(declare-const var2300!1 String)
(declare-const var1325!1 Int)
(define-const var1880 Bool (var2706_isNotEmpty/-1251449450 var1358)) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>(r1) 
 ; Statement: if $z0 == 0 goto virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r0) 
(assert (= (ite var1880 1 0) 0)) ; Cond: $z0 == 0 
(assert true)
;(assert (append/672562846 var2300!1 var1976)) ; Statement: virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r0) 
(declare-const var2300!2 String)
(assert (= var2300!2 (str.++ var2300!1 var1976)))
(define-const var847 Bool (var2706_isNotEmpty/-1251449450 var2231)) ; Statement: $z1 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>(r2) 
 ; Statement: if $z1 == 0 goto $r4 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.String toString()>() 
(assert (= (ite var847 1 0) 0)) ; Cond: $z1 == 0 
(assert true)
(define-const var3553 String (toString/-2075883882 var2300!2)) ; Statement: $r4 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.String toString()>() 
 ; Statement: return $r4 
(check-sat)
; {String-init=([], java.lang.StringBuilder), <init>/543593434=([java.lang.StringBuilder, int], void), var2706_isNotEmpty/-1251449450=([java.lang.String], boolean), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), toString/-2075883882=([java.lang.StringBuilder], java.lang.String)}
; {var1976=r0, var2641=null_type, var1358=r1, var2231=r2, var3972=$i3, var3047=$i1, var2307=$i4, var2468=$i2, var3081=$i5, var2414=$i0, var1325=i6, var2300=$r3, var2706=org.apache.dubbo.common.utils.StringUtils, var1880=$z0, var847=$z1, var3553=$r4}
; {r0=var1976, null_type=var2641, r1=var1358, r2=var2231, $i3=var3972, $i1=var3047, $i4=var2307, $i2=var2468, $i5=var3081, $i0=var2414, i6=var1325, $r3=var2300, org.apache.dubbo.common.utils.StringUtils=var2706, $z0=var1880, $z1=var847, $r4=var3553}
;seq <java.lang.StringBuilder: void <init>(int)>;	<org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>(int)>": 1,"<org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>": 2,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 1,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r0 := @parameter0: java.lang.String;	r1 := @parameter1: java.lang.String;	r2 := @parameter2: java.lang.String;	if r0 != null goto $i3 = virtualinvoke r0.<java.lang.String: int length()>();	$i3 = 0;	goto [?= $i1 = $i3];	$i1 = $i3;	if r1 != null goto $i4 = virtualinvoke r1.<java.lang.String: int length()>();	$i4 = 0;	goto [?= $i2 = $i1 + $i4];	$i2 = $i1 + $i4;	if r2 != null goto $i5 = virtualinvoke r2.<java.lang.String: int length()>();	$i5 = 0;	goto [?= $i0 = $i2 + $i5];	$i0 = $i2 + $i5;	i6 = $i0 + 2;	$r3 = new java.lang.StringBuilder;	specialinvoke $r3.<java.lang.StringBuilder: void <init>(int)>(i6);	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>(r1);	if $z0 == 0 goto virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r0);	virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r0);	$z1 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>(r2);	if $z1 == 0 goto $r4 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.String toString()>();	$r4 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.String toString()>();	return $r4
;block_num 9