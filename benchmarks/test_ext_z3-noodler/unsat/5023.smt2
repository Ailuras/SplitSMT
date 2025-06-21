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

(declare-sort var2031 0)
(declare-sort var3317 0)
(declare-sort var2832 0)
(declare-sort var592 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun getParameter/-1307325648 (var2031 String) String)
(declare-fun var592_isBlank/-523695098 (String) Bool)
(define-fun cast-from-String-to-String ((arg String)) String arg)
(declare-const null-var2031 var2031)
(declare-const null-String String)
(declare-const null-ClassObject ClassObject)
(declare-const null-var2832 var2832)
(declare-const var3757 var2031) ; Statement: r0 := @this: org.apache.dubbo.common.URL 
(assert (not (= var3757 null-var2031)))
(declare-const var355 String) ; Statement: r1 := @parameter0: java.lang.String 
(assert (not (= var355 null-String)))
(declare-const var2189 ClassObject) ; Statement: r7 := @parameter1: java.lang.Class 
(assert (not (= var2189 null-ClassObject)))
(declare-const var3876 var2832) ; Statement: r3 := @parameter2: java.lang.Object 
(assert (not (= var3876 null-var2832)))
(assert true)
(define-const var1962 String (getParameter/-1307325648 var3757 var355)) ; Statement: r2 = virtualinvoke r0.<org.apache.dubbo.common.URL: java.lang.String getParameter(java.lang.String)>(r1) 
(define-const var970 var2832 null-var2832) ; Statement: r9 = null 
(define-const var3758 Bool (var592_isBlank/-523695098 (cast-from-String-to-String var1962))) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isBlank(java.lang.CharSequence)>(r2) 
 ; Statement: if $z0 != 0 goto (branch) 
(assert (not (= (ite var3758 1 0) 0))) ; Cond: $z0 != 0 
 ; Statement: if r9 != null goto return r9 
(assert (not (= var970 null-var2832))) ; Cond: r9 != null 
 ; Statement: return r9 
(check-sat)
; {getParameter/-1307325648=([org.apache.dubbo.common.URL, java.lang.String], java.lang.String), var592_isBlank/-523695098=([java.lang.CharSequence], boolean), cast-from-String-to-String=([java.lang.String], java.lang.CharSequence)}
; {var2031=org.apache.dubbo.common.URL, var3757=r0, var355=r1, var3317=null_type, var2189=r7, var2832=java.lang.Object, var3876=r3, var1962=r2, var970=r9, var592=org.apache.dubbo.common.utils.StringUtils, var3758=$z0}
; {org.apache.dubbo.common.URL=var2031, r0=var3757, r1=var355, null_type=var3317, r7=var2189, java.lang.Object=var2832, r3=var3876, r2=var1962, r9=var970, org.apache.dubbo.common.utils.StringUtils=var592, $z0=var3758}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isBlank(java.lang.CharSequence)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isBlank(java.lang.CharSequence)>": 1}
;stmts r0 := @this: org.apache.dubbo.common.URL;	r1 := @parameter0: java.lang.String;	r7 := @parameter1: java.lang.Class;	r3 := @parameter2: java.lang.Object;	r2 = virtualinvoke r0.<org.apache.dubbo.common.URL: java.lang.String getParameter(java.lang.String)>(r1);	r9 = null;	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isBlank(java.lang.CharSequence)>(r2);	if $z0 != 0 goto (branch);	if r9 != null goto return r9;	return r9
;block_num 3