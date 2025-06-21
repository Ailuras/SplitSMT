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

(declare-sort var1807 0)
(declare-sort var684 0)
(declare-sort var820 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun getServices/-1334158029 (var1807) String)
(declare-fun var820_splitToSet/-482269659 (String Int) var684)
(declare-const null-var1807 var1807)
(declare-const var1578 var1807) ; Statement: r0 := @this: org.apache.dubbo.config.ReferenceConfig 
(assert (not (= var1578 null-var1807)))
(assert true)
(define-const var3536 String (getServices/-1334158029 var1578)) ; Statement: $r1 = virtualinvoke r0.<org.apache.dubbo.config.ReferenceConfig: java.lang.String getServices()>() 
(define-const var3445 var684 (var820_splitToSet/-482269659 var3536 44)) ; Statement: $r2 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: java.util.Set splitToSet(java.lang.String,char)>($r1, 44) 
 ; Statement: return $r2 
(check-sat)
; {getServices/-1334158029=([org.apache.dubbo.config.ReferenceConfig], java.lang.String), var820_splitToSet/-482269659=([java.lang.String, char], java.util.Set)}
; {var1807=org.apache.dubbo.config.ReferenceConfig, var1578=r0, var3536=$r1, var684=java.util.Set, var820=org.apache.dubbo.common.utils.StringUtils, var3445=$r2}
; {org.apache.dubbo.config.ReferenceConfig=var1807, r0=var1578, $r1=var3536, java.util.Set=var684, org.apache.dubbo.common.utils.StringUtils=var820, $r2=var3445}
;seq <org.apache.dubbo.common.utils.StringUtils: java.util.Set splitToSet(java.lang.String,char)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: java.util.Set splitToSet(java.lang.String,char)>": 1}
;stmts r0 := @this: org.apache.dubbo.config.ReferenceConfig;	$r1 = virtualinvoke r0.<org.apache.dubbo.config.ReferenceConfig: java.lang.String getServices()>();	$r2 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: java.util.Set splitToSet(java.lang.String,char)>($r1, 44);	return $r2
;block_num 1