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

(declare-sort var399 0)
(declare-sort var2792 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun getPort/20614931 (var2792) Int)
(declare-fun String_valueOf/1240665136 (Int) String)
(declare-const null-var399 var399)
(declare-const null-var2792 var2792)
(declare-const var1972 var399) ; Statement: r2 := @this: org.apache.dubbo.common.threadpool.manager.DefaultExecutorRepository 
(assert (not (= var1972 null-var399)))
(declare-const var3343 var2792) ; Statement: r0 := @parameter0: org.apache.dubbo.common.URL 
(assert (not (= var3343 null-var2792)))
(assert true)
(define-const var2403 Int (getPort/20614931 var3343)) ; Statement: $i0 = virtualinvoke r0.<org.apache.dubbo.common.URL: int getPort()>() 
(define-const var116 String (String_valueOf/1240665136 var2403)) ; Statement: $r1 = staticinvoke <java.lang.String: java.lang.String valueOf(int)>($i0) 
 ; Statement: return $r1 
(check-sat)
; {getPort/20614931=([org.apache.dubbo.common.URL], int), String_valueOf/1240665136=([int], java.lang.String)}
; {var399=org.apache.dubbo.common.threadpool.manager.DefaultExecutorRepository, var1972=r2, var2792=org.apache.dubbo.common.URL, var3343=r0, var2403=$i0, var116=$r1}
; {org.apache.dubbo.common.threadpool.manager.DefaultExecutorRepository=var399, r2=var1972, org.apache.dubbo.common.URL=var2792, r0=var3343, $i0=var2403, $r1=var116}
;seq <java.lang.String: java.lang.String valueOf(int)>
;cnt {"<java.lang.String: java.lang.String valueOf(int)>": 1}
;stmts r2 := @this: org.apache.dubbo.common.threadpool.manager.DefaultExecutorRepository;	r0 := @parameter0: org.apache.dubbo.common.URL;	$i0 = virtualinvoke r0.<org.apache.dubbo.common.URL: int getPort()>();	$r1 = staticinvoke <java.lang.String: java.lang.String valueOf(int)>($i0);	return $r1
;block_num 1