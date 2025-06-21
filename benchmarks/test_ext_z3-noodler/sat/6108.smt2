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

(declare-sort var3471 0)
(declare-sort var2159 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun address/1294285035 (var3471) String)
(declare-fun var2159_isNotEmpty/-1251449450 (String) Bool)
(declare-const null-var3471 var3471)
(declare-const var3490 var3471) ; Statement: r0 := @this: org.apache.dubbo.config.MetadataReportConfig 
(assert (not (= var3490 null-var3471)))
(define-const var2638 String (address/1294285035 var3490)) ; Statement: $r1 = r0.<org.apache.dubbo.config.MetadataReportConfig: java.lang.String address> 
(define-const var2179 Bool (var2159_isNotEmpty/-1251449450 var2638)) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>($r1) 
 ; Statement: return $z0 
(check-sat)
; {address/1294285035=([org.apache.dubbo.config.MetadataReportConfig], java.lang.String), var2159_isNotEmpty/-1251449450=([java.lang.String], boolean)}
; {var3471=org.apache.dubbo.config.MetadataReportConfig, var3490=r0, var2638=$r1, var2159=org.apache.dubbo.common.utils.StringUtils, var2179=$z0}
; {org.apache.dubbo.config.MetadataReportConfig=var3471, r0=var3490, $r1=var2638, org.apache.dubbo.common.utils.StringUtils=var2159, $z0=var2179}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>": 1}
;stmts r0 := @this: org.apache.dubbo.config.MetadataReportConfig;	$r1 = r0.<org.apache.dubbo.config.MetadataReportConfig: java.lang.String address>;	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>($r1);	return $z0
;block_num 1