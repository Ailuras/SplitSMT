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

(declare-sort var2919 0)
(declare-sort var1233 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var2919_getKey/-33423493 (var2919) var1233)
(declare-fun cast-from-var1233-to-String (var1233) String)
(define-fun startsWith/-1785782452 ((s String) (prefix String)) Bool (str.prefixof prefix s))
(declare-const null-var2919 var2919)
(declare-const var3693 var2919) ; Statement: r0 := @parameter0: java.util.Map$Entry 
(assert (not (= var3693 null-var2919)))
(define-const var558 var1233 (var2919_getKey/-33423493 var3693)) ; Statement: $r1 = interfaceinvoke r0.<java.util.Map$Entry: java.lang.Object getKey()>() 
(define-const var1852 String (cast-from-var1233-to-String var558)) ; Statement: $r2 = (java.lang.String) $r1 
(assert true)
(define-const var3151 Bool (startsWith/-1785782452 var1852 "DubboServerHandler")) ; Statement: $z0 = virtualinvoke $r2.<java.lang.String: boolean startsWith(java.lang.String)>("DubboServerHandler") 
 ; Statement: return $z0 
(check-sat)
; {var2919_getKey/-33423493=([java.util.Map$Entry], java.lang.Object), cast-from-var1233-to-String=([java.lang.Object], java.lang.String), startsWith/-1785782452=([java.lang.String, java.lang.String], boolean)}
; {var2919=java.util.Map$Entry, var3693=r0, var1233=java.lang.Object, var558=$r1, var1852=$r2, var3151=$z0}
; {java.util.Map$Entry=var2919, r0=var3693, java.lang.Object=var1233, $r1=var558, $r2=var1852, $z0=var3151}
;seq <java.lang.String: boolean startsWith(java.lang.String)>
;cnt {"<java.lang.String: boolean startsWith(java.lang.String)>": 1}
;stmts r0 := @parameter0: java.util.Map$Entry;	$r1 = interfaceinvoke r0.<java.util.Map$Entry: java.lang.Object getKey()>();	$r2 = (java.lang.String) $r1;	$z0 = virtualinvoke $r2.<java.lang.String: boolean startsWith(java.lang.String)>("DubboServerHandler");	return $z0
;block_num 1