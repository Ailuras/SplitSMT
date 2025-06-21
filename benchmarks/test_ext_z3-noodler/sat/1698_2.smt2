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

(declare-sort var2915 0)
(declare-sort var850 0)
(declare-sort var2856 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var2856_isNotEmpty/-1251449450 (String) Bool)
(declare-fun Int_valueOf/1677026208 (String) Int)
(declare-const null-var2915 var2915)
(declare-const null-String String)
(declare-const var3674 var2915) ; Statement: r1 := @this: org.apache.dubbo.common.convert.StringToByteConverter 
(assert (not (= var3674 null-var2915)))
(declare-const var1833 String) ; Statement: r0 := @parameter0: java.lang.String 
(assert (not (= var1833 null-String)))
(define-const var2228 Bool (var2856_isNotEmpty/-1251449450 var1833)) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>(r0) 
 ; Statement: if $z0 == 0 goto $r2 = null 
(assert (not (= (ite var2228 1 0) 0))) ; Negate: Cond: $z0 == 0  
(define-const var3282 Int (Int_valueOf/1677026208 var1833)) ; Statement: $r2 = staticinvoke <java.lang.Byte: java.lang.Byte valueOf(java.lang.String)>(r0) 
 ; Statement: goto [?= return $r2] 
(assert true) ; Non Conditional
 ; Statement: return $r2 
(check-sat)
; {var2856_isNotEmpty/-1251449450=([java.lang.String], boolean), Int_valueOf/1677026208=([java.lang.String], java.lang.Byte)}
; {var2915=org.apache.dubbo.common.convert.StringToByteConverter, var3674=r1, var1833=r0, var850=null_type, var2856=org.apache.dubbo.common.utils.StringUtils, var2228=$z0, var3282=$r2}
; {org.apache.dubbo.common.convert.StringToByteConverter=var2915, r1=var3674, r0=var1833, null_type=var850, org.apache.dubbo.common.utils.StringUtils=var2856, $z0=var2228, $r2=var3282}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>": 1}
;stmts r1 := @this: org.apache.dubbo.common.convert.StringToByteConverter;	r0 := @parameter0: java.lang.String;	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>(r0);	if $z0 == 0 goto $r2 = null;	$r2 = staticinvoke <java.lang.Byte: java.lang.Byte valueOf(java.lang.String)>(r0);	goto [?= return $r2];	return $r2
;block_num 3