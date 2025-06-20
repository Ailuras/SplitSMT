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

(declare-sort var2547 0)
(declare-sort var1865 0)
(declare-sort var2995 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun cast-from-var1865-to-String (var1865) String)
(declare-fun var2995_isNotBlank/-358081771 (String) Bool)
(define-fun cast-from-String-to-String ((arg String)) String arg)
(declare-const null-var2547 var2547)
(declare-const null-var1865 var1865)
(declare-const var1992 var2547) ; Statement: $r0 := @this: org.apache.dubbo.remoting.utils.UrlUtils$isNotBlank__1233 
(assert (not (= var1992 null-var2547)))
(declare-const var3060 var1865) ; Statement: $r1 := @parameter0: java.lang.Object 
(assert (not (= var3060 null-var1865)))
(define-const var2366 String (cast-from-var1865-to-String var3060)) ; Statement: $r2 = (java.lang.String) $r1 
(define-const var1760 Bool (var2995_isNotBlank/-358081771 (cast-from-String-to-String var2366))) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNotBlank(java.lang.CharSequence)>($r2) 
 ; Statement: return $z0 
(check-sat)
; {cast-from-var1865-to-String=([java.lang.Object], java.lang.String), var2995_isNotBlank/-358081771=([java.lang.CharSequence], boolean), cast-from-String-to-String=([java.lang.String], java.lang.CharSequence)}
; {var2547=org.apache.dubbo.remoting.utils.UrlUtils$isNotBlank__1233, var1992=$r0, var1865=java.lang.Object, var3060=$r1, var2366=$r2, var2995=org.apache.dubbo.common.utils.StringUtils, var1760=$z0}
; {org.apache.dubbo.remoting.utils.UrlUtils$isNotBlank__1233=var2547, $r0=var1992, java.lang.Object=var1865, $r1=var3060, $r2=var2366, org.apache.dubbo.common.utils.StringUtils=var2995, $z0=var1760}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isNotBlank(java.lang.CharSequence)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isNotBlank(java.lang.CharSequence)>": 1}
;stmts $r0 := @this: org.apache.dubbo.remoting.utils.UrlUtils$isNotBlank__1233;	$r1 := @parameter0: java.lang.Object;	$r2 = (java.lang.String) $r1;	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNotBlank(java.lang.CharSequence)>($r2);	return $z0
;block_num 1