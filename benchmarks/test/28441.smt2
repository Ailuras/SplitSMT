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

(declare-sort var2343 0)
(declare-sort var1001 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun cast-from-var1001-to-String (var1001) String)
(define-fun is-whitespace ((char String)) Bool (< (str.to_code char) 33))
(define-fun-rec trim-left ((s String)) String (ite (= s "") "" (ite (is-whitespace (str.substr s 0 1)) (trim-left (str.substr s 1 (- (str.len s) 1))) s)))
(define-fun-rec trim-right ((s String)) String (ite (= s "") "" (ite (is-whitespace (str.substr s (- (str.len s) 1) 1)) (trim-right (str.substr s 0 (- (str.len s) 1))) s)))
(define-fun trim/-847153721 ((s String)) String (trim-right (trim-left s)))
(declare-const null-var2343 var2343)
(declare-const null-var1001 var1001)
(declare-const var3274 var2343) ; Statement: $r0 := @this: org.apache.dubbo.common.utils.StringUtils$trim__297 
(assert (not (= var3274 null-var2343)))
(declare-const var883 var1001) ; Statement: $r1 := @parameter0: java.lang.Object 
(assert (not (= var883 null-var1001)))
(define-const var3786 String (cast-from-var1001-to-String var883)) ; Statement: $r2 = (java.lang.String) $r1 
(assert true)
(define-const var1630 String (trim/-847153721 var3786)) ; Statement: $r3 = virtualinvoke $r2.<java.lang.String: java.lang.String trim()>() 
 ; Statement: return $r3 
(check-sat)
; {cast-from-var1001-to-String=([java.lang.Object], java.lang.String), trim/-847153721=([java.lang.String], java.lang.String)}
; {var2343=org.apache.dubbo.common.utils.StringUtils$trim__297, var3274=$r0, var1001=java.lang.Object, var883=$r1, var3786=$r2, var1630=$r3}
; {org.apache.dubbo.common.utils.StringUtils$trim__297=var2343, $r0=var3274, java.lang.Object=var1001, $r1=var883, $r2=var3786, $r3=var1630}
;seq <java.lang.String: java.lang.String trim()>
;cnt {"<java.lang.String: java.lang.String trim()>": 1}
;stmts $r0 := @this: org.apache.dubbo.common.utils.StringUtils$trim__297;	$r1 := @parameter0: java.lang.Object;	$r2 = (java.lang.String) $r1;	$r3 = virtualinvoke $r2.<java.lang.String: java.lang.String trim()>();	return $r3
;block_num 1