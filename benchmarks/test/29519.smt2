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

(declare-sort var2626 0)
(declare-sort var3545 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun cast-from-var3545-to-String (var3545) String)
(define-fun is-whitespace ((char String)) Bool (< (str.to_code char) 33))
(define-fun-rec trim-left ((s String)) String (ite (= s "") "" (ite (is-whitespace (str.substr s 0 1)) (trim-left (str.substr s 1 (- (str.len s) 1))) s)))
(define-fun-rec trim-right ((s String)) String (ite (= s "") "" (ite (is-whitespace (str.substr s (- (str.len s) 1) 1)) (trim-right (str.substr s 0 (- (str.len s) 1))) s)))
(define-fun trim/-847153721 ((s String)) String (trim-right (trim-left s)))
(declare-const null-var2626 var2626)
(declare-const null-var3545 var3545)
(declare-const var806 var2626) ; Statement: $r0 := @this: org.apache.dubbo.config.spring.util.DubboAnnotationUtils$trim__563 
(assert (not (= var806 null-var2626)))
(declare-const var3894 var3545) ; Statement: $r1 := @parameter0: java.lang.Object 
(assert (not (= var3894 null-var3545)))
(define-const var946 String (cast-from-var3545-to-String var3894)) ; Statement: $r2 = (java.lang.String) $r1 
(assert true)
(define-const var593 String (trim/-847153721 var946)) ; Statement: $r3 = virtualinvoke $r2.<java.lang.String: java.lang.String trim()>() 
 ; Statement: return $r3 
(check-sat)
; {cast-from-var3545-to-String=([java.lang.Object], java.lang.String), trim/-847153721=([java.lang.String], java.lang.String)}
; {var2626=org.apache.dubbo.config.spring.util.DubboAnnotationUtils$trim__563, var806=$r0, var3545=java.lang.Object, var3894=$r1, var946=$r2, var593=$r3}
; {org.apache.dubbo.config.spring.util.DubboAnnotationUtils$trim__563=var2626, $r0=var806, java.lang.Object=var3545, $r1=var3894, $r2=var946, $r3=var593}
;seq <java.lang.String: java.lang.String trim()>
;cnt {"<java.lang.String: java.lang.String trim()>": 1}
;stmts $r0 := @this: org.apache.dubbo.config.spring.util.DubboAnnotationUtils$trim__563;	$r1 := @parameter0: java.lang.Object;	$r2 = (java.lang.String) $r1;	$r3 = virtualinvoke $r2.<java.lang.String: java.lang.String trim()>();	return $r3
;block_num 1