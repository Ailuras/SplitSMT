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

(declare-sort var808 0)
(declare-sort var867 0)
(declare-sort var636 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun getMethodParameter/-740962196 (var808 String String String) String)
(declare-fun var636_isNotEmpty/-1251449450 (String) Bool)
(declare-const null-var808 var808)
(declare-const null-String String)
(declare-const null-NullType var867)
(declare-const var3908 var808) ; Statement: r0 := @this: org.apache.dubbo.metadata.MetadataInfo$ServiceInfo 
(assert (not (= var3908 null-var808)))
(declare-const var516 String) ; Statement: r1 := @parameter0: java.lang.String 
(assert (not (= var516 null-String)))
(declare-const var1928 String) ; Statement: r2 := @parameter1: java.lang.String 
(assert (not (= var1928 null-String)))
(assert true)
(define-const var3328 String (getMethodParameter/-740962196 var3908 var516 var1928 null-String)) ; Statement: r3 = virtualinvoke r0.<org.apache.dubbo.metadata.MetadataInfo$ServiceInfo: java.lang.String getMethodParameter(java.lang.String,java.lang.String,java.lang.String)>(r1, r2, null) 
(define-const var3810 Bool (var636_isNotEmpty/-1251449450 var3328)) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>(r3) 
 ; Statement: return $z0 
(check-sat)
; {getMethodParameter/-740962196=([org.apache.dubbo.metadata.MetadataInfo$ServiceInfo, java.lang.String, java.lang.String, java.lang.String], java.lang.String), var636_isNotEmpty/-1251449450=([java.lang.String], boolean)}
; {var808=org.apache.dubbo.metadata.MetadataInfo$ServiceInfo, var3908=r0, var516=r1, var867=null_type, var1928=r2, var3328=r3, var636=org.apache.dubbo.common.utils.StringUtils, var3810=$z0}
; {org.apache.dubbo.metadata.MetadataInfo$ServiceInfo=var808, r0=var3908, r1=var516, null_type=var867, r2=var1928, r3=var3328, org.apache.dubbo.common.utils.StringUtils=var636, $z0=var3810}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>": 1}
;stmts r0 := @this: org.apache.dubbo.metadata.MetadataInfo$ServiceInfo;	r1 := @parameter0: java.lang.String;	r2 := @parameter1: java.lang.String;	r3 = virtualinvoke r0.<org.apache.dubbo.metadata.MetadataInfo$ServiceInfo: java.lang.String getMethodParameter(java.lang.String,java.lang.String,java.lang.String)>(r1, r2, null);	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>(r3);	return $z0
;block_num 1