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

(declare-sort var1079 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(declare-fun var1079_isPublic/-426263739 (Int) Bool)
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(declare-fun var1079_isStatic/379715466 (Int) Bool)
(declare-fun var1079_isVolatile/2145303608 (Int) Bool)
(define-fun toString/-2075883882 ((s String)) String s)
(declare-const null-Int Int)
(declare-const var3383 Int) ; Statement: i0 := @parameter0: int 
(assert (not (= var3383 null-Int)))
(define-const var2538 String String-init) ; Statement: $r0 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var2538)) ; Statement: specialinvoke $r0.<java.lang.StringBuilder: void <init>()>() 
(declare-const var2538!1 String)
(assert (= var2538!1 ""))
(define-const var1918 Bool (var1079_isPublic/-426263739 var3383)) ; Statement: $z0 = staticinvoke <java.lang.reflect.Modifier: boolean isPublic(int)>(i0) 
 ; Statement: if $z0 == 0 goto $z1 = staticinvoke <java.lang.reflect.Modifier: boolean isProtected(int)>(i0) 
(assert (not (= (ite var1918 1 0) 0))) ; Negate: Cond: $z0 == 0  
(assert true)
;(assert (append/672562846 var2538!1 "public")) ; Statement: virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("public") 
(declare-const var2538!2 String)
(assert (= var2538!2 (str.++ var2538!1 "public")))
 ; Statement: goto [?= $z4 = staticinvoke <java.lang.reflect.Modifier: boolean isStatic(int)>(i0)] 
(assert true) ; Non Conditional
(define-const var2937 Bool (var1079_isStatic/379715466 var3383)) ; Statement: $z4 = staticinvoke <java.lang.reflect.Modifier: boolean isStatic(int)>(i0) 
 ; Statement: if $z4 == 0 goto $z3 = staticinvoke <java.lang.reflect.Modifier: boolean isVolatile(int)>(i0) 
(assert (= (ite var2937 1 0) 0)) ; Cond: $z4 == 0 
(define-const var965 Bool (var1079_isVolatile/2145303608 var3383)) ; Statement: $z3 = staticinvoke <java.lang.reflect.Modifier: boolean isVolatile(int)>(i0) 
 ; Statement: if $z3 == 0 goto $r1 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.String toString()>() 
(assert (= (ite var965 1 0) 0)) ; Cond: $z3 == 0 
(assert true)
(define-const var381 String (toString/-2075883882 var2538!2)) ; Statement: $r1 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.String toString()>() 
 ; Statement: return $r1 
(check-sat)
; {String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), var1079_isPublic/-426263739=([int], boolean), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), var1079_isStatic/379715466=([int], boolean), var1079_isVolatile/2145303608=([int], boolean), toString/-2075883882=([java.lang.StringBuilder], java.lang.String)}
; {var3383=i0, var2538=$r0, var1079=java.lang.reflect.Modifier, var1918=$z0, var2937=$z4, var965=$z3, var381=$r1}
; {i0=var3383, $r0=var2538, java.lang.reflect.Modifier=var1079, $z0=var1918, $z4=var2937, $z3=var965, $r1=var381}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 1,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts i0 := @parameter0: int;	$r0 = new java.lang.StringBuilder;	specialinvoke $r0.<java.lang.StringBuilder: void <init>()>();	$z0 = staticinvoke <java.lang.reflect.Modifier: boolean isPublic(int)>(i0);	if $z0 == 0 goto $z1 = staticinvoke <java.lang.reflect.Modifier: boolean isProtected(int)>(i0);	virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("public");	goto [?= $z4 = staticinvoke <java.lang.reflect.Modifier: boolean isStatic(int)>(i0)];	$z4 = staticinvoke <java.lang.reflect.Modifier: boolean isStatic(int)>(i0);	if $z4 == 0 goto $z3 = staticinvoke <java.lang.reflect.Modifier: boolean isVolatile(int)>(i0);	$z3 = staticinvoke <java.lang.reflect.Modifier: boolean isVolatile(int)>(i0);	if $z3 == 0 goto $r1 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.String toString()>();	$r1 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.String toString()>();	return $r1
;block_num 5