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

(declare-sort var1776 0)
(declare-sort var3682 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun String_valueOf/1240665136 (Int) String)
(declare-const null-var1776 var1776)
(declare-const null-var3682 var3682)
(declare-const var2532 var1776) ; Statement: r1 := @this: org.apache.dubbo.common.threadpool.manager.DefaultExecutorRepository 
(assert (not (= var2532 null-var1776)))
(declare-const var1563 var3682) ; Statement: r2 := @parameter0: org.apache.dubbo.common.URL 
(assert (not (= var1563 null-var3682)))
(define-const var3739 String (String_valueOf/1240665136 2147483647)) ; Statement: $r0 = staticinvoke <java.lang.String: java.lang.String valueOf(int)>(2147483647) 
 ; Statement: return $r0 
(check-sat)
; {String_valueOf/1240665136=([int], java.lang.String)}
; {var1776=org.apache.dubbo.common.threadpool.manager.DefaultExecutorRepository, var2532=r1, var3682=org.apache.dubbo.common.URL, var1563=r2, var3739=$r0}
; {org.apache.dubbo.common.threadpool.manager.DefaultExecutorRepository=var1776, r1=var2532, org.apache.dubbo.common.URL=var3682, r2=var1563, $r0=var3739}
;seq <java.lang.String: java.lang.String valueOf(int)>
;cnt {"<java.lang.String: java.lang.String valueOf(int)>": 1}
;stmts r1 := @this: org.apache.dubbo.common.threadpool.manager.DefaultExecutorRepository;	r2 := @parameter0: org.apache.dubbo.common.URL;	$r0 = staticinvoke <java.lang.String: java.lang.String valueOf(int)>(2147483647);	return $r0
;block_num 1