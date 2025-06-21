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

(declare-sort var2748 0)
(declare-sort var199 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun cast-from-var199-to-String (var199) String)
(declare-fun cap0/-2079084463 (var2748) String)
(define-fun startsWith/-1785782452 ((s String) (prefix String)) Bool (str.prefixof prefix s))
(declare-const null-var2748 var2748)
(declare-const null-var199 var199)
(declare-const var1866 var2748) ; Statement: $r0 := @this: org.apache.dubbo.common.serialize.fastjson2.Fastjson2SecurityManager$Handler$startsWith__1502 
(assert (not (= var1866 null-var2748)))
(declare-const var2645 var199) ; Statement: $r1 := @parameter0: java.lang.Object 
(assert (not (= var2645 null-var199)))
(define-const var1639 String (cast-from-var199-to-String var2645)) ; Statement: $r2 = (java.lang.String) $r1 
(define-const var3060 String (cap0/-2079084463 var1866)) ; Statement: $r3 = $r0.<org.apache.dubbo.common.serialize.fastjson2.Fastjson2SecurityManager$Handler$startsWith__1502: java.lang.String cap0> 
(assert true)
(define-const var1481 Bool (startsWith/-1785782452 var3060 var1639)) ; Statement: $z0 = virtualinvoke $r3.<java.lang.String: boolean startsWith(java.lang.String)>($r2) 
 ; Statement: return $z0 
(check-sat)
; {cast-from-var199-to-String=([java.lang.Object], java.lang.String), cap0/-2079084463=([org.apache.dubbo.common.serialize.fastjson2.Fastjson2SecurityManager$Handler$startsWith__1502], java.lang.String), startsWith/-1785782452=([java.lang.String, java.lang.String], boolean)}
; {var2748=org.apache.dubbo.common.serialize.fastjson2.Fastjson2SecurityManager$Handler$startsWith__1502, var1866=$r0, var199=java.lang.Object, var2645=$r1, var1639=$r2, var3060=$r3, var1481=$z0}
; {org.apache.dubbo.common.serialize.fastjson2.Fastjson2SecurityManager$Handler$startsWith__1502=var2748, $r0=var1866, java.lang.Object=var199, $r1=var2645, $r2=var1639, $r3=var3060, $z0=var1481}
;seq <java.lang.String: boolean startsWith(java.lang.String)>
;cnt {"<java.lang.String: boolean startsWith(java.lang.String)>": 1}
;stmts $r0 := @this: org.apache.dubbo.common.serialize.fastjson2.Fastjson2SecurityManager$Handler$startsWith__1502;	$r1 := @parameter0: java.lang.Object;	$r2 = (java.lang.String) $r1;	$r3 = $r0.<org.apache.dubbo.common.serialize.fastjson2.Fastjson2SecurityManager$Handler$startsWith__1502: java.lang.String cap0>;	$z0 = virtualinvoke $r3.<java.lang.String: boolean startsWith(java.lang.String)>($r2);	return $z0
;block_num 1