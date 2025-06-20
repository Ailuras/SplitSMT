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

(declare-sort var884 0)
(declare-sort var1026 0)
(declare-sort var2981 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var1026_split/-1711975109 (String Int) (Array Int String))
(declare-fun var2981-init () var2981)
(declare-fun <init>/500456927 (var2981) void)
(declare-const null-String String)
(declare-const null-__Array__Int__String__ (Array Int String))
(declare-const var972 String) ; Statement: r0 := @parameter0: java.lang.String 
(assert (not (= var972 null-String)))
(define-const var899 (Array Int String) (var1026_split/-1711975109 var972 58)) ; Statement: r1 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: java.lang.String[] split(java.lang.String,char)>(r0, 58) 
 ; Statement: if r1 == null goto $r5 = new org.apache.dubbo.common.BaseServiceMetadata 
(assert (= var899 null-__Array__Int__String__)) ; Cond: r1 == null 
(define-const var3592 var2981 var2981-init) ; Statement: $r5 = new org.apache.dubbo.common.BaseServiceMetadata 
(assert true)
;(assert (<init>/500456927 var3592)) ; Statement: specialinvoke $r5.<org.apache.dubbo.common.BaseServiceMetadata: void <init>()>() 

(declare-const var3592!1 var2981)
 ; Statement: return $r5 
(check-sat)
; {var1026_split/-1711975109=([java.lang.String, char], java.lang.String[]), var2981-init=([], org.apache.dubbo.common.BaseServiceMetadata), <init>/500456927=([org.apache.dubbo.common.BaseServiceMetadata], void)}
; {var972=r0, var884=null_type, var1026=org.apache.dubbo.common.utils.StringUtils, var899=r1, var2981=org.apache.dubbo.common.BaseServiceMetadata, var3592=$r5}
; {r0=var972, null_type=var884, org.apache.dubbo.common.utils.StringUtils=var1026, r1=var899, org.apache.dubbo.common.BaseServiceMetadata=var2981, $r5=var3592}
;seq <org.apache.dubbo.common.utils.StringUtils: java.lang.String[] split(java.lang.String,char)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: java.lang.String[] split(java.lang.String,char)>": 1}
;stmts r0 := @parameter0: java.lang.String;	r1 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: java.lang.String[] split(java.lang.String,char)>(r0, 58);	if r1 == null goto $r5 = new org.apache.dubbo.common.BaseServiceMetadata;	$r5 = new org.apache.dubbo.common.BaseServiceMetadata;	specialinvoke $r5.<org.apache.dubbo.common.BaseServiceMetadata: void <init>()>();	return $r5
;block_num 2