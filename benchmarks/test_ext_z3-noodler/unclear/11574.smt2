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

(declare-sort var2447 0)
(declare-sort var2485 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(define-fun cast-from-Int-to-Int ((arg Int)) Int arg)
(declare-fun var2485-init () var2485)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(declare-fun append/33611274 (String Float64) String)
(define-fun toString/-2075883882 ((s String)) String s)
(declare-fun <init>/875830710 (var2485 String) void)
(declare-const null-var2447 var2447)
(declare-const null-Float64 Float64)
(declare-const var2799 var2447) ; Statement: r5 := @this: org.apache.dubbo.metrics.aggregate.DubboMergingDigest 
(assert (not (= var2799 null-var2447)))
(declare-const var2883 Float64) ; Statement: d0 := @parameter0: double 
(assert (not (= var2883 null-Float64)))
(define-const var3960 Int (ite (fp.gt var2883 ((_ to_fp 11 53) #x0000000000000000)) 1 (ite (fp.lt var2883 ((_ to_fp 11 53) #x0000000000000000)) -1 0))) ; Statement: $b0 = d0 cmpg 0.0 
(define-const var542 Int (cast-from-Int-to-Int var3960)) ; Statement: $i34 = (int) $b0 
 ; Statement: if $i34 < 0 goto $r36 = new java.lang.IllegalArgumentException 
(assert (< var542 0)) ; Cond: $i34 < 0 
(define-const var3339 var2485 var2485-init) ; Statement: $r36 = new java.lang.IllegalArgumentException 
(define-const var1687 String String-init) ; Statement: $r35 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var1687)) ; Statement: specialinvoke $r35.<java.lang.StringBuilder: void <init>()>() 
(declare-const var1687!1 String)
(assert (= var1687!1 ""))
(assert true)
(define-const var3432 String (append/672562846 var1687!1 "q should be in [0,1], got ")) ; Statement: $r2 = virtualinvoke $r35.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("q should be in [0,1], got ") 
(declare-const var1687!2 String)
(assert (= var1687!2 (str.++ var1687!1 "q should be in [0,1], got ")))
(assert true)
(define-const var482 String (append/33611274 var3432 var2883)) ; Statement: $r3 = virtualinvoke $r2.<java.lang.StringBuilder: java.lang.StringBuilder append(double)>(d0) 
(declare-const var3432!1 String)
(assert (str.prefixof var3432 var3432!1))
(assert true)
(define-const var3946 String (toString/-2075883882 var482)) ; Statement: $r4 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.String toString()>() 
(assert true)
;(assert (<init>/875830710 var3339 var3946)) ; Statement: specialinvoke $r36.<java.lang.IllegalArgumentException: void <init>(java.lang.String)>($r4) 

(declare-const var3339!1 var2485)
(declare-const var3946!1 String)
 ; Statement: throw $r36 
(check-sat)
; {cast-from-Int-to-Int=([byte], int), var2485-init=([], java.lang.IllegalArgumentException), String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), append/33611274=([java.lang.StringBuilder, double], java.lang.StringBuilder), toString/-2075883882=([java.lang.StringBuilder], java.lang.String), <init>/875830710=([java.lang.IllegalArgumentException, java.lang.String], void)}
; {var2447=org.apache.dubbo.metrics.aggregate.DubboMergingDigest, var2799=r5, var2883=d0, var3960=$b0, var542=$i34, var2485=java.lang.IllegalArgumentException, var3339=$r36, var1687=$r35, var3432=$r2, var482=$r3, var3946=$r4}
; {org.apache.dubbo.metrics.aggregate.DubboMergingDigest=var2447, r5=var2799, d0=var2883, $b0=var3960, $i34=var542, java.lang.IllegalArgumentException=var2485, $r36=var3339, $r35=var1687, $r2=var3432, $r3=var482, $r4=var3946}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(double)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(double)>": 1,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r5 := @this: org.apache.dubbo.metrics.aggregate.DubboMergingDigest;	d0 := @parameter0: double;	$b0 = d0 cmpg 0.0;	$i34 = (int) $b0;	if $i34 < 0 goto $r36 = new java.lang.IllegalArgumentException;	$r36 = new java.lang.IllegalArgumentException;	$r35 = new java.lang.StringBuilder;	specialinvoke $r35.<java.lang.StringBuilder: void <init>()>();	$r2 = virtualinvoke $r35.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("q should be in [0,1], got ");	$r3 = virtualinvoke $r2.<java.lang.StringBuilder: java.lang.StringBuilder append(double)>(d0);	$r4 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.String toString()>();	specialinvoke $r36.<java.lang.IllegalArgumentException: void <init>(java.lang.String)>($r4);	throw $r36
;block_num 2