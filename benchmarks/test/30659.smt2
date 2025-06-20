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

(declare-sort var273 0)
(declare-sort var3797 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun cast-from-var3797-to-String (var3797) String)
(define-fun is-whitespace ((char String)) Bool (< (str.to_code char) 33))
(define-fun-rec trim-left ((s String)) String (ite (= s "") "" (ite (is-whitespace (str.substr s 0 1)) (trim-left (str.substr s 1 (- (str.len s) 1))) s)))
(define-fun-rec trim-right ((s String)) String (ite (= s "") "" (ite (is-whitespace (str.substr s (- (str.len s) 1) 1)) (trim-right (str.substr s 0 (- (str.len s) 1))) s)))
(define-fun trim/-847153721 ((s String)) String (trim-right (trim-left s)))
(declare-const null-var273 var273)
(declare-const null-var3797 var3797)
(declare-const var3868 var273) ; Statement: $r0 := @this: org.apache.dubbo.qos.permission.DefaultAnonymousAccessPermissionChecker$trim__928 
(assert (not (= var3868 null-var273)))
(declare-const var789 var3797) ; Statement: $r1 := @parameter0: java.lang.Object 
(assert (not (= var789 null-var3797)))
(define-const var3153 String (cast-from-var3797-to-String var789)) ; Statement: $r2 = (java.lang.String) $r1 
(assert true)
(define-const var3698 String (trim/-847153721 var3153)) ; Statement: $r3 = virtualinvoke $r2.<java.lang.String: java.lang.String trim()>() 
 ; Statement: return $r3 
(check-sat)
; {cast-from-var3797-to-String=([java.lang.Object], java.lang.String), trim/-847153721=([java.lang.String], java.lang.String)}
; {var273=org.apache.dubbo.qos.permission.DefaultAnonymousAccessPermissionChecker$trim__928, var3868=$r0, var3797=java.lang.Object, var789=$r1, var3153=$r2, var3698=$r3}
; {org.apache.dubbo.qos.permission.DefaultAnonymousAccessPermissionChecker$trim__928=var273, $r0=var3868, java.lang.Object=var3797, $r1=var789, $r2=var3153, $r3=var3698}
;seq <java.lang.String: java.lang.String trim()>
;cnt {"<java.lang.String: java.lang.String trim()>": 1}
;stmts $r0 := @this: org.apache.dubbo.qos.permission.DefaultAnonymousAccessPermissionChecker$trim__928;	$r1 := @parameter0: java.lang.Object;	$r2 = (java.lang.String) $r1;	$r3 = virtualinvoke $r2.<java.lang.String: java.lang.String trim()>();	return $r3
;block_num 1