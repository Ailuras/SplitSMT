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

(declare-sort var2295 0)
(declare-sort var2983 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun cast-from-var2983-to-String (var2983) String)
(define-fun is-whitespace ((char String)) Bool (< (str.to_code char) 33))
(define-fun-rec trim-left ((s String)) String (ite (= s "") "" (ite (is-whitespace (str.substr s 0 1)) (trim-left (str.substr s 1 (- (str.len s) 1))) s)))
(define-fun-rec trim-right ((s String)) String (ite (= s "") "" (ite (is-whitespace (str.substr s (- (str.len s) 1) 1)) (trim-right (str.substr s 0 (- (str.len s) 1))) s)))
(define-fun trim/-847153721 ((s String)) String (trim-right (trim-left s)))
(declare-const null-var2295 var2295)
(declare-const null-var2983 var2983)
(declare-const var1479 var2295) ; Statement: $r0 := @this: org.apache.dubbo.metadata.ServiceNameMapping$trim__625 
(assert (not (= var1479 null-var2295)))
(declare-const var279 var2983) ; Statement: $r1 := @parameter0: java.lang.Object 
(assert (not (= var279 null-var2983)))
(define-const var2287 String (cast-from-var2983-to-String var279)) ; Statement: $r2 = (java.lang.String) $r1 
(assert true)
(define-const var2901 String (trim/-847153721 var2287)) ; Statement: $r3 = virtualinvoke $r2.<java.lang.String: java.lang.String trim()>() 
 ; Statement: return $r3 
(check-sat)
; {cast-from-var2983-to-String=([java.lang.Object], java.lang.String), trim/-847153721=([java.lang.String], java.lang.String)}
; {var2295=org.apache.dubbo.metadata.ServiceNameMapping$trim__625, var1479=$r0, var2983=java.lang.Object, var279=$r1, var2287=$r2, var2901=$r3}
; {org.apache.dubbo.metadata.ServiceNameMapping$trim__625=var2295, $r0=var1479, java.lang.Object=var2983, $r1=var279, $r2=var2287, $r3=var2901}
;seq <java.lang.String: java.lang.String trim()>
;cnt {"<java.lang.String: java.lang.String trim()>": 1}
;stmts $r0 := @this: org.apache.dubbo.metadata.ServiceNameMapping$trim__625;	$r1 := @parameter0: java.lang.Object;	$r2 = (java.lang.String) $r1;	$r3 = virtualinvoke $r2.<java.lang.String: java.lang.String trim()>();	return $r3
;block_num 1