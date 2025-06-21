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

(declare-sort var3324 0)
(declare-sort var2356 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun cast-from-var2356-to-String (var2356) String)
(define-fun is-whitespace ((char String)) Bool (< (str.to_code char) 33))
(define-fun-rec trim-left ((s String)) String (ite (= s "") "" (ite (is-whitespace (str.substr s 0 1)) (trim-left (str.substr s 1 (- (str.len s) 1))) s)))
(define-fun-rec trim-right ((s String)) String (ite (= s "") "" (ite (is-whitespace (str.substr s (- (str.len s) 1) 1)) (trim-right (str.substr s 0 (- (str.len s) 1))) s)))
(define-fun trim/-847153721 ((s String)) String (trim-right (trim-left s)))
(declare-const null-var3324 var3324)
(declare-const null-var2356 var2356)
(declare-const var2450 var3324) ; Statement: $r0 := @this: org.apache.dubbo.config.spring.util.DubboAnnotationUtils$trim__583 
(assert (not (= var2450 null-var3324)))
(declare-const var3584 var2356) ; Statement: $r1 := @parameter0: java.lang.Object 
(assert (not (= var3584 null-var2356)))
(define-const var125 String (cast-from-var2356-to-String var3584)) ; Statement: $r2 = (java.lang.String) $r1 
(assert true)
(define-const var2689 String (trim/-847153721 var125)) ; Statement: $r3 = virtualinvoke $r2.<java.lang.String: java.lang.String trim()>() 
 ; Statement: return $r3 
(check-sat)
; {cast-from-var2356-to-String=([java.lang.Object], java.lang.String), trim/-847153721=([java.lang.String], java.lang.String)}
; {var3324=org.apache.dubbo.config.spring.util.DubboAnnotationUtils$trim__583, var2450=$r0, var2356=java.lang.Object, var3584=$r1, var125=$r2, var2689=$r3}
; {org.apache.dubbo.config.spring.util.DubboAnnotationUtils$trim__583=var3324, $r0=var2450, java.lang.Object=var2356, $r1=var3584, $r2=var125, $r3=var2689}
;seq <java.lang.String: java.lang.String trim()>
;cnt {"<java.lang.String: java.lang.String trim()>": 1}
;stmts $r0 := @this: org.apache.dubbo.config.spring.util.DubboAnnotationUtils$trim__583;	$r1 := @parameter0: java.lang.Object;	$r2 = (java.lang.String) $r1;	$r3 = virtualinvoke $r2.<java.lang.String: java.lang.String trim()>();	return $r3
;block_num 1