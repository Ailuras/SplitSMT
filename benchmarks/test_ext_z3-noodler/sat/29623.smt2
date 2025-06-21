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

(declare-sort var1765 0)
(declare-sort var3727 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun cast-from-var3727-to-String (var3727) String)
(define-fun is-whitespace ((char String)) Bool (< (str.to_code char) 33))
(define-fun-rec trim-left ((s String)) String (ite (= s "") "" (ite (is-whitespace (str.substr s 0 1)) (trim-left (str.substr s 1 (- (str.len s) 1))) s)))
(define-fun-rec trim-right ((s String)) String (ite (= s "") "" (ite (is-whitespace (str.substr s (- (str.len s) 1) 1)) (trim-right (str.substr s 0 (- (str.len s) 1))) s)))
(define-fun trim/-847153721 ((s String)) String (trim-right (trim-left s)))
(declare-const null-var1765 var1765)
(declare-const null-var3727 var3727)
(declare-const var2810 var1765) ; Statement: $r0 := @this: org.apache.dubbo.metadata.AbstractServiceNameMapping$trim__605 
(assert (not (= var2810 null-var1765)))
(declare-const var2518 var3727) ; Statement: $r1 := @parameter0: java.lang.Object 
(assert (not (= var2518 null-var3727)))
(define-const var2217 String (cast-from-var3727-to-String var2518)) ; Statement: $r2 = (java.lang.String) $r1 
(assert true)
(define-const var881 String (trim/-847153721 var2217)) ; Statement: $r3 = virtualinvoke $r2.<java.lang.String: java.lang.String trim()>() 
 ; Statement: return $r3 
(check-sat)
; {cast-from-var3727-to-String=([java.lang.Object], java.lang.String), trim/-847153721=([java.lang.String], java.lang.String)}
; {var1765=org.apache.dubbo.metadata.AbstractServiceNameMapping$trim__605, var2810=$r0, var3727=java.lang.Object, var2518=$r1, var2217=$r2, var881=$r3}
; {org.apache.dubbo.metadata.AbstractServiceNameMapping$trim__605=var1765, $r0=var2810, java.lang.Object=var3727, $r1=var2518, $r2=var2217, $r3=var881}
;seq <java.lang.String: java.lang.String trim()>
;cnt {"<java.lang.String: java.lang.String trim()>": 1}
;stmts $r0 := @this: org.apache.dubbo.metadata.AbstractServiceNameMapping$trim__605;	$r1 := @parameter0: java.lang.Object;	$r2 = (java.lang.String) $r1;	$r3 = virtualinvoke $r2.<java.lang.String: java.lang.String trim()>();	return $r3
;block_num 1