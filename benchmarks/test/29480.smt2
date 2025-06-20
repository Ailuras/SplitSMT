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

(declare-sort var593 0)
(declare-sort var1196 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun cast-from-var1196-to-String (var1196) String)
(define-fun is-whitespace ((char String)) Bool (< (str.to_code char) 33))
(define-fun-rec trim-left ((s String)) String (ite (= s "") "" (ite (is-whitespace (str.substr s 0 1)) (trim-left (str.substr s 1 (- (str.len s) 1))) s)))
(define-fun-rec trim-right ((s String)) String (ite (= s "") "" (ite (is-whitespace (str.substr s (- (str.len s) 1) 1)) (trim-right (str.substr s 0 (- (str.len s) 1))) s)))
(define-fun trim/-847153721 ((s String)) String (trim-right (trim-left s)))
(declare-const null-var593 var593)
(declare-const null-var1196 var1196)
(declare-const var3396 var593) ; Statement: $r0 := @this: org.apache.dubbo.config.spring.util.DubboAnnotationUtils$trim__562 
(assert (not (= var3396 null-var593)))
(declare-const var388 var1196) ; Statement: $r1 := @parameter0: java.lang.Object 
(assert (not (= var388 null-var1196)))
(define-const var2204 String (cast-from-var1196-to-String var388)) ; Statement: $r2 = (java.lang.String) $r1 
(assert true)
(define-const var3287 String (trim/-847153721 var2204)) ; Statement: $r3 = virtualinvoke $r2.<java.lang.String: java.lang.String trim()>() 
 ; Statement: return $r3 
(check-sat)
; {cast-from-var1196-to-String=([java.lang.Object], java.lang.String), trim/-847153721=([java.lang.String], java.lang.String)}
; {var593=org.apache.dubbo.config.spring.util.DubboAnnotationUtils$trim__562, var3396=$r0, var1196=java.lang.Object, var388=$r1, var2204=$r2, var3287=$r3}
; {org.apache.dubbo.config.spring.util.DubboAnnotationUtils$trim__562=var593, $r0=var3396, java.lang.Object=var1196, $r1=var388, $r2=var2204, $r3=var3287}
;seq <java.lang.String: java.lang.String trim()>
;cnt {"<java.lang.String: java.lang.String trim()>": 1}
;stmts $r0 := @this: org.apache.dubbo.config.spring.util.DubboAnnotationUtils$trim__562;	$r1 := @parameter0: java.lang.Object;	$r2 = (java.lang.String) $r1;	$r3 = virtualinvoke $r2.<java.lang.String: java.lang.String trim()>();	return $r3
;block_num 1