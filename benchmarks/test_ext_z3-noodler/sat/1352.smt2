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

(declare-sort var653 0)
(declare-sort var1534 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(define-fun is-whitespace ((char String)) Bool (< (str.to_code char) 33))
(define-fun-rec trim-left ((s String)) String (ite (= s "") "" (ite (is-whitespace (str.substr s 0 1)) (trim-left (str.substr s 1 (- (str.len s) 1))) s)))
(define-fun-rec trim-right ((s String)) String (ite (= s "") "" (ite (is-whitespace (str.substr s (- (str.len s) 1) 1)) (trim-right (str.substr s 0 (- (str.len s) 1))) s)))
(define-fun trim/-847153721 ((s String)) String (trim-right (trim-left s)))
(declare-fun addInterface/472537069 (var653 String) void)
(declare-const null-var653 var653)
(declare-const null-String String)
(declare-const var2329 var653) ; Statement: r0 := @parameter0: org.apache.dubbo.common.compiler.support.CtClassBuilder 
(assert (not (= var2329 null-var653)))
(declare-const var2567 String) ; Statement: r1 := @parameter1: java.lang.String 
(assert (not (= var2567 null-String)))
(assert true)
(define-const var3089 String (trim/-847153721 var2567)) ; Statement: $r2 = virtualinvoke r1.<java.lang.String: java.lang.String trim()>() 
(assert true)
;(assert (addInterface/472537069 var2329 var3089)) ; Statement: virtualinvoke r0.<org.apache.dubbo.common.compiler.support.CtClassBuilder: void addInterface(java.lang.String)>($r2) 

(declare-const var2329!1 var653)
(declare-const var3089!1 String)
 ; Statement: return 
(check-sat)
; {trim/-847153721=([java.lang.String], java.lang.String), addInterface/472537069=([org.apache.dubbo.common.compiler.support.CtClassBuilder, java.lang.String], void)}
; {var653=org.apache.dubbo.common.compiler.support.CtClassBuilder, var2329=r0, var2567=r1, var1534=null_type, var3089=$r2}
; {org.apache.dubbo.common.compiler.support.CtClassBuilder=var653, r0=var2329, r1=var2567, null_type=var1534, $r2=var3089}
;seq <java.lang.String: java.lang.String trim()>
;cnt {"<java.lang.String: java.lang.String trim()>": 1}
;stmts r0 := @parameter0: org.apache.dubbo.common.compiler.support.CtClassBuilder;	r1 := @parameter1: java.lang.String;	$r2 = virtualinvoke r1.<java.lang.String: java.lang.String trim()>();	virtualinvoke r0.<org.apache.dubbo.common.compiler.support.CtClassBuilder: void addInterface(java.lang.String)>($r2);	return
;block_num 1