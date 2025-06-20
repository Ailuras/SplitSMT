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

(declare-sort var2977 0)
(declare-sort var566 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun cast-from-var566-to-String (var566) String)
(declare-fun cap0/1938374933 (var2977) String)
(define-fun startsWith/-1785782452 ((s String) (prefix String)) Bool (str.prefixof prefix s))
(declare-const null-var2977 var2977)
(declare-const null-var566 var566)
(declare-const var1955 var2977) ; Statement: $r0 := @this: org.apache.dubbo.common.utils.SerializeSecurityManager$startsWith__290 
(assert (not (= var1955 null-var2977)))
(declare-const var301 var566) ; Statement: $r1 := @parameter0: java.lang.Object 
(assert (not (= var301 null-var566)))
(define-const var2841 String (cast-from-var566-to-String var301)) ; Statement: $r2 = (java.lang.String) $r1 
(define-const var424 String (cap0/1938374933 var1955)) ; Statement: $r3 = $r0.<org.apache.dubbo.common.utils.SerializeSecurityManager$startsWith__290: java.lang.String cap0> 
(assert true)
(define-const var99 Bool (startsWith/-1785782452 var424 var2841)) ; Statement: $z0 = virtualinvoke $r3.<java.lang.String: boolean startsWith(java.lang.String)>($r2) 
 ; Statement: return $z0 
(check-sat)
; {cast-from-var566-to-String=([java.lang.Object], java.lang.String), cap0/1938374933=([org.apache.dubbo.common.utils.SerializeSecurityManager$startsWith__290], java.lang.String), startsWith/-1785782452=([java.lang.String, java.lang.String], boolean)}
; {var2977=org.apache.dubbo.common.utils.SerializeSecurityManager$startsWith__290, var1955=$r0, var566=java.lang.Object, var301=$r1, var2841=$r2, var424=$r3, var99=$z0}
; {org.apache.dubbo.common.utils.SerializeSecurityManager$startsWith__290=var2977, $r0=var1955, java.lang.Object=var566, $r1=var301, $r2=var2841, $r3=var424, $z0=var99}
;seq <java.lang.String: boolean startsWith(java.lang.String)>
;cnt {"<java.lang.String: boolean startsWith(java.lang.String)>": 1}
;stmts $r0 := @this: org.apache.dubbo.common.utils.SerializeSecurityManager$startsWith__290;	$r1 := @parameter0: java.lang.Object;	$r2 = (java.lang.String) $r1;	$r3 = $r0.<org.apache.dubbo.common.utils.SerializeSecurityManager$startsWith__290: java.lang.String cap0>;	$z0 = virtualinvoke $r3.<java.lang.String: boolean startsWith(java.lang.String)>($r2);	return $z0
;block_num 1