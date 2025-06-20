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

(declare-sort var3030 0)
(declare-sort var3943 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun cast-from-var3943-to-String (var3943) String)
(define-fun is-whitespace ((char String)) Bool (< (str.to_code char) 33))
(define-fun-rec trim-left ((s String)) String (ite (= s "") "" (ite (is-whitespace (str.substr s 0 1)) (trim-left (str.substr s 1 (- (str.len s) 1))) s)))
(define-fun-rec trim-right ((s String)) String (ite (= s "") "" (ite (is-whitespace (str.substr s (- (str.len s) 1) 1)) (trim-right (str.substr s 0 (- (str.len s) 1))) s)))
(define-fun trim/-847153721 ((s String)) String (trim-right (trim-left s)))
(declare-const null-var3030 var3030)
(declare-const null-var3943 var3943)
(declare-const var3306 var3030) ; Statement: $r0 := @this: org.apache.dubbo.common.compiler.support.JavassistCompiler$trim__142 
(assert (not (= var3306 null-var3030)))
(declare-const var879 var3943) ; Statement: $r1 := @parameter0: java.lang.Object 
(assert (not (= var879 null-var3943)))
(define-const var1795 String (cast-from-var3943-to-String var879)) ; Statement: $r2 = (java.lang.String) $r1 
(assert true)
(define-const var2834 String (trim/-847153721 var1795)) ; Statement: $r3 = virtualinvoke $r2.<java.lang.String: java.lang.String trim()>() 
 ; Statement: return $r3 
(check-sat)
; {cast-from-var3943-to-String=([java.lang.Object], java.lang.String), trim/-847153721=([java.lang.String], java.lang.String)}
; {var3030=org.apache.dubbo.common.compiler.support.JavassistCompiler$trim__142, var3306=$r0, var3943=java.lang.Object, var879=$r1, var1795=$r2, var2834=$r3}
; {org.apache.dubbo.common.compiler.support.JavassistCompiler$trim__142=var3030, $r0=var3306, java.lang.Object=var3943, $r1=var879, $r2=var1795, $r3=var2834}
;seq <java.lang.String: java.lang.String trim()>
;cnt {"<java.lang.String: java.lang.String trim()>": 1}
;stmts $r0 := @this: org.apache.dubbo.common.compiler.support.JavassistCompiler$trim__142;	$r1 := @parameter0: java.lang.Object;	$r2 = (java.lang.String) $r1;	$r3 = virtualinvoke $r2.<java.lang.String: java.lang.String trim()>();	return $r3
;block_num 1