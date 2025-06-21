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

(declare-sort var1902 0)
(declare-sort var2674 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun cast-from-var2674-to-String (var2674) String)
(define-fun is-whitespace ((char String)) Bool (< (str.to_code char) 33))
(define-fun-rec trim-left ((s String)) String (ite (= s "") "" (ite (is-whitespace (str.substr s 0 1)) (trim-left (str.substr s 1 (- (str.len s) 1))) s)))
(define-fun-rec trim-right ((s String)) String (ite (= s "") "" (ite (is-whitespace (str.substr s (- (str.len s) 1) 1)) (trim-right (str.substr s 0 (- (str.len s) 1))) s)))
(define-fun trim/-847153721 ((s String)) String (trim-right (trim-left s)))
(declare-const null-var1902 var1902)
(declare-const null-var2674 var2674)
(declare-const var3403 var1902) ; Statement: $r0 := @this: org.apache.dubbo.rpc.protocol.tri.rest.mapping.meta.CorsMeta$Builder$trim__1461 
(assert (not (= var3403 null-var1902)))
(declare-const var3890 var2674) ; Statement: $r1 := @parameter0: java.lang.Object 
(assert (not (= var3890 null-var2674)))
(define-const var1425 String (cast-from-var2674-to-String var3890)) ; Statement: $r2 = (java.lang.String) $r1 
(assert true)
(define-const var98 String (trim/-847153721 var1425)) ; Statement: $r3 = virtualinvoke $r2.<java.lang.String: java.lang.String trim()>() 
 ; Statement: return $r3 
(check-sat)
; {cast-from-var2674-to-String=([java.lang.Object], java.lang.String), trim/-847153721=([java.lang.String], java.lang.String)}
; {var1902=org.apache.dubbo.rpc.protocol.tri.rest.mapping.meta.CorsMeta$Builder$trim__1461, var3403=$r0, var2674=java.lang.Object, var3890=$r1, var1425=$r2, var98=$r3}
; {org.apache.dubbo.rpc.protocol.tri.rest.mapping.meta.CorsMeta$Builder$trim__1461=var1902, $r0=var3403, java.lang.Object=var2674, $r1=var3890, $r2=var1425, $r3=var98}
;seq <java.lang.String: java.lang.String trim()>
;cnt {"<java.lang.String: java.lang.String trim()>": 1}
;stmts $r0 := @this: org.apache.dubbo.rpc.protocol.tri.rest.mapping.meta.CorsMeta$Builder$trim__1461;	$r1 := @parameter0: java.lang.Object;	$r2 = (java.lang.String) $r1;	$r3 = virtualinvoke $r2.<java.lang.String: java.lang.String trim()>();	return $r3
;block_num 1