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

(declare-sort var3225 0)
(declare-sort var509 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun name/1190736640 (var3225) String)
(declare-fun var509_isNotEmpty/-1251449450 (String) Bool)
(declare-const null-var3225 var3225)
(declare-const var2763 var3225) ; Statement: r0 := @this: org.apache.dubbo.config.ProtocolConfig 
(assert (not (= var2763 null-var3225)))
(define-const var1898 String (name/1190736640 var2763)) ; Statement: $r1 = r0.<org.apache.dubbo.config.ProtocolConfig: java.lang.String name> 
(define-const var2388 Bool (var509_isNotEmpty/-1251449450 var1898)) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>($r1) 
 ; Statement: return $z0 
(check-sat)
; {name/1190736640=([org.apache.dubbo.config.ProtocolConfig], java.lang.String), var509_isNotEmpty/-1251449450=([java.lang.String], boolean)}
; {var3225=org.apache.dubbo.config.ProtocolConfig, var2763=r0, var1898=$r1, var509=org.apache.dubbo.common.utils.StringUtils, var2388=$z0}
; {org.apache.dubbo.config.ProtocolConfig=var3225, r0=var2763, $r1=var1898, org.apache.dubbo.common.utils.StringUtils=var509, $z0=var2388}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>": 1}
;stmts r0 := @this: org.apache.dubbo.config.ProtocolConfig;	$r1 = r0.<org.apache.dubbo.config.ProtocolConfig: java.lang.String name>;	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>($r1);	return $z0
;block_num 1