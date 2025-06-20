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

(declare-sort var779 0)
(declare-sort var828 0)
(declare-sort var3458 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun getPort/20614931 (var3458) Int)
(declare-fun String_valueOf/1240665136 (Int) String)
(declare-const null-var779 var779)
(declare-const null-var828 var828)
(declare-const null-var3458 var3458)
(declare-const var2839 var779) ; Statement: r2 := @this: org.apache.dubbo.common.threadpool.manager.DefaultExecutorRepository 
(assert (not (= var2839 null-var779)))
(declare-const var1902 var828) ; Statement: r3 := @parameter0: org.apache.dubbo.rpc.model.ProviderModel 
(assert (not (= var1902 null-var828)))
(declare-const var1591 var3458) ; Statement: r0 := @parameter1: org.apache.dubbo.common.URL 
(assert (not (= var1591 null-var3458)))
(assert true)
(define-const var2127 Int (getPort/20614931 var1591)) ; Statement: $i0 = virtualinvoke r0.<org.apache.dubbo.common.URL: int getPort()>() 
(define-const var161 String (String_valueOf/1240665136 var2127)) ; Statement: $r1 = staticinvoke <java.lang.String: java.lang.String valueOf(int)>($i0) 
 ; Statement: return $r1 
(check-sat)
; {getPort/20614931=([org.apache.dubbo.common.URL], int), String_valueOf/1240665136=([int], java.lang.String)}
; {var779=org.apache.dubbo.common.threadpool.manager.DefaultExecutorRepository, var2839=r2, var828=org.apache.dubbo.rpc.model.ProviderModel, var1902=r3, var3458=org.apache.dubbo.common.URL, var1591=r0, var2127=$i0, var161=$r1}
; {org.apache.dubbo.common.threadpool.manager.DefaultExecutorRepository=var779, r2=var2839, org.apache.dubbo.rpc.model.ProviderModel=var828, r3=var1902, org.apache.dubbo.common.URL=var3458, r0=var1591, $i0=var2127, $r1=var161}
;seq <java.lang.String: java.lang.String valueOf(int)>
;cnt {"<java.lang.String: java.lang.String valueOf(int)>": 1}
;stmts r2 := @this: org.apache.dubbo.common.threadpool.manager.DefaultExecutorRepository;	r3 := @parameter0: org.apache.dubbo.rpc.model.ProviderModel;	r0 := @parameter1: org.apache.dubbo.common.URL;	$i0 = virtualinvoke r0.<org.apache.dubbo.common.URL: int getPort()>();	$r1 = staticinvoke <java.lang.String: java.lang.String valueOf(int)>($i0);	return $r1
;block_num 1