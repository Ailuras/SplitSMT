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

(declare-sort var1678 0)
(declare-sort var100 0)
(declare-sort var3421 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun getParameter/-1307325648 (var1678 String) String)
(declare-fun var3421_isBlank/-523695098 (String) Bool)
(define-fun cast-from-String-to-String ((arg String)) String arg)
(declare-fun append/-1166366385 (String Int) String)
(declare-const null-var1678 var1678)
(declare-const null-String String)
(declare-const null-Bool Bool)
(declare-const var3906 var1678) ; Statement: r0 := @this: org.apache.dubbo.common.URL 
(assert (not (= var3906 null-var1678)))
(declare-const var1649 String) ; Statement: r3 := @parameter0: java.lang.StringBuilder 
(assert (not (= var1649 null-String)))
(declare-const var2876 String) ; Statement: r1 := @parameter1: java.lang.String 
(assert (not (= var2876 null-String)))
(declare-const var819 Bool) ; Statement: z1 := @parameter2: boolean 
(assert (not (= var819 null-Bool)))
(assert true)
(define-const var3137 String (getParameter/-1307325648 var3906 var2876)) ; Statement: r2 = virtualinvoke r0.<org.apache.dubbo.common.URL: java.lang.String getParameter(java.lang.String)>(r1) 
(define-const var493 Bool (var3421_isBlank/-523695098 (cast-from-String-to-String var3137))) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isBlank(java.lang.CharSequence)>(r2) 
 ; Statement: if $z0 != 0 goto virtualinvoke r3.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(58) 
(assert (not (= (ite var493 1 0) 0))) ; Cond: $z0 != 0 
(assert true)
;(assert (append/-1166366385 var1649 58)) ; Statement: virtualinvoke r3.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(58) 
(declare-const var1649!1 String)
(assert (str.prefixof var1649 var1649!1))
(assert true) ; Non Conditional
 ; Statement: return 
(check-sat)
; {getParameter/-1307325648=([org.apache.dubbo.common.URL, java.lang.String], java.lang.String), var3421_isBlank/-523695098=([java.lang.CharSequence], boolean), cast-from-String-to-String=([java.lang.String], java.lang.CharSequence), append/-1166366385=([java.lang.StringBuilder, char], java.lang.StringBuilder)}
; {var1678=org.apache.dubbo.common.URL, var3906=r0, var1649=r3, var2876=r1, var100=null_type, var819=z1, var3137=r2, var3421=org.apache.dubbo.common.utils.StringUtils, var493=$z0}
; {org.apache.dubbo.common.URL=var1678, r0=var3906, r3=var1649, r1=var2876, null_type=var100, z1=var819, r2=var3137, org.apache.dubbo.common.utils.StringUtils=var3421, $z0=var493}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isBlank(java.lang.CharSequence)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(char)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isBlank(java.lang.CharSequence)>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(char)>": 1}
;stmts r0 := @this: org.apache.dubbo.common.URL;	r3 := @parameter0: java.lang.StringBuilder;	r1 := @parameter1: java.lang.String;	z1 := @parameter2: boolean;	r2 = virtualinvoke r0.<org.apache.dubbo.common.URL: java.lang.String getParameter(java.lang.String)>(r1);	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isBlank(java.lang.CharSequence)>(r2);	if $z0 != 0 goto virtualinvoke r3.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(58);	virtualinvoke r3.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(58);	return
;block_num 3