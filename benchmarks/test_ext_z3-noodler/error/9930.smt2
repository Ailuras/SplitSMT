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

(declare-sort var562 0)
(declare-sort var3890 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(define-fun replace/2138489945 ((s String) (old String) (new String)) String (str.replace_all s old new))
(define-fun cast-from-String-to-String ((arg String)) String arg)
(define-fun replace/1524665721 ((s String) (old_char Int) (new_char Int)) String (str.replace_all s (str.from_code old_char) (str.from_code new_char)))
(declare-const null-var562 var562)
(declare-const null-String String)
(declare-const var3271 var562) ; Statement: r3 := @this: org.apache.dubbo.configcenter.support.nacos.NacosConfigServiceWrapper 
(assert (not (= var3271 null-var562)))
(declare-const var601 String) ; Statement: r0 := @parameter0: java.lang.String 
(assert (not (= var601 null-String)))
 ; Statement: if r0 != null goto $r1 = virtualinvoke r0.<java.lang.String: java.lang.String replace(java.lang.CharSequence,java.lang.CharSequence)>("$", "___") 
(assert (not (= var601 null-String))) ; Cond: r0 != null 
(assert true)
(define-const var3203 String (replace/2138489945 var601 (cast-from-String-to-String "$") (cast-from-String-to-String "___"))) ; Statement: $r1 = virtualinvoke r0.<java.lang.String: java.lang.String replace(java.lang.CharSequence,java.lang.CharSequence)>("$", "___") 
(assert true)
(define-const var226 String (replace/1524665721 var3203 47 45)) ; Statement: $r2 = virtualinvoke $r1.<java.lang.String: java.lang.String replace(char,char)>(47, 45) 
 ; Statement: return $r2 
(check-sat)
; {replace/2138489945=([java.lang.String, java.lang.CharSequence, java.lang.CharSequence], java.lang.String), cast-from-String-to-String=([java.lang.String], java.lang.CharSequence), replace/1524665721=([java.lang.String, char, char], java.lang.String)}
; {var562=org.apache.dubbo.configcenter.support.nacos.NacosConfigServiceWrapper, var3271=r3, var601=r0, var3890=null_type, var3203=$r1, var226=$r2}
; {org.apache.dubbo.configcenter.support.nacos.NacosConfigServiceWrapper=var562, r3=var3271, r0=var601, null_type=var3890, $r1=var3203, $r2=var226}
;seq <java.lang.String: java.lang.String replace(java.lang.CharSequence,java.lang.CharSequence)>;	<java.lang.String: java.lang.String replace(char,char)>
;cnt {"<java.lang.String: java.lang.String replace(java.lang.CharSequence,java.lang.CharSequence)>": 1,"<java.lang.String: java.lang.String replace(char,char)>": 1}
;stmts r3 := @this: org.apache.dubbo.configcenter.support.nacos.NacosConfigServiceWrapper;	r0 := @parameter0: java.lang.String;	if r0 != null goto $r1 = virtualinvoke r0.<java.lang.String: java.lang.String replace(java.lang.CharSequence,java.lang.CharSequence)>("$", "___");	$r1 = virtualinvoke r0.<java.lang.String: java.lang.String replace(java.lang.CharSequence,java.lang.CharSequence)>("$", "___");	$r2 = virtualinvoke $r1.<java.lang.String: java.lang.String replace(char,char)>(47, 45);	return $r2
;block_num 2