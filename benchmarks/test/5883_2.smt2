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

(declare-sort var1268 0)
(declare-sort var2731 0)
(declare-sort var1919 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-const var1919!class ClassObject)
(declare-fun var2731_getErrorTypeAwareLogger/453021605 (ClassObject) var1268)
(declare-fun String_valueOf/1240665136 (Int) String)
(define-const var3127 var1268 (var2731_getErrorTypeAwareLogger/453021605 var1919!class)) ; Statement: $r0 = staticinvoke <org.apache.dubbo.common.logger.LoggerFactory: org.apache.dubbo.common.logger.ErrorTypeAwareLogger getErrorTypeAwareLogger(java.lang.Class)>(class "Lorg/apache/dubbo/common/threadpool/manager/DefaultExecutorRepository;") 
(define-const var3692 var1268 var3127) ; Statement: <org.apache.dubbo.common.threadpool.manager.DefaultExecutorRepository: org.apache.dubbo.common.logger.ErrorTypeAwareLogger logger> = $r0 
(define-const var471 String (String_valueOf/1240665136 2147483647)) ; Statement: $r1 = staticinvoke <java.lang.String: java.lang.String valueOf(int)>(2147483647) 
(define-const var1130 String var471) ; Statement: <org.apache.dubbo.common.threadpool.manager.DefaultExecutorRepository: java.lang.String MAX_KEY> = $r1 
 ; Statement: return 
(check-sat)
; {var2731_getErrorTypeAwareLogger/453021605=([java.lang.Class], org.apache.dubbo.common.logger.ErrorTypeAwareLogger), String_valueOf/1240665136=([int], java.lang.String)}
; {var1268=org.apache.dubbo.common.logger.ErrorTypeAwareLogger, var2731=org.apache.dubbo.common.logger.LoggerFactory, var1919=org.apache.dubbo.common.threadpool.manager.DefaultExecutorRepository, var3127=$r0, var3692=<org.apache.dubbo.common.threadpool.manager.DefaultExecutorRepository: org.apache.dubbo.common.logger.ErrorTypeAwareLogger logger>, var471=$r1, var1130=<org.apache.dubbo.common.threadpool.manager.DefaultExecutorRepository: java.lang.String MAX_KEY>}
; {org.apache.dubbo.common.logger.ErrorTypeAwareLogger=var1268, org.apache.dubbo.common.logger.LoggerFactory=var2731, org.apache.dubbo.common.threadpool.manager.DefaultExecutorRepository=var1919, $r0=var3127, <org.apache.dubbo.common.threadpool.manager.DefaultExecutorRepository: org.apache.dubbo.common.logger.ErrorTypeAwareLogger logger>=var3692, $r1=var471, <org.apache.dubbo.common.threadpool.manager.DefaultExecutorRepository: java.lang.String MAX_KEY>=var1130}
;seq <java.lang.String: java.lang.String valueOf(int)>
;cnt {"<java.lang.String: java.lang.String valueOf(int)>": 1}
;stmts $r0 = staticinvoke <org.apache.dubbo.common.logger.LoggerFactory: org.apache.dubbo.common.logger.ErrorTypeAwareLogger getErrorTypeAwareLogger(java.lang.Class)>(class "Lorg/apache/dubbo/common/threadpool/manager/DefaultExecutorRepository;");	<org.apache.dubbo.common.threadpool.manager.DefaultExecutorRepository: org.apache.dubbo.common.logger.ErrorTypeAwareLogger logger> = $r0;	$r1 = staticinvoke <java.lang.String: java.lang.String valueOf(int)>(2147483647);	<org.apache.dubbo.common.threadpool.manager.DefaultExecutorRepository: java.lang.String MAX_KEY> = $r1;	return
;block_num 1