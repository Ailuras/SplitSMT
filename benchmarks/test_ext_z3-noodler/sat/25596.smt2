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

(declare-sort var3551 0)
(declare-sort var2528 0)
(declare-sort var117 0)
(declare-sort var2993 0)
(declare-sort var324 0)
(declare-sort var1793 0)
(declare-sort var1476 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var3551_headerValues/-959957846 (var3551 String) var2528)
(define-fun cast-from-String-to-String ((arg String)) String arg)
(declare-fun var117-init () var117)
(declare-fun <init>/22626498 (var117 var2993) void)
(declare-fun cast-from-var2528-to-var2993 (var2528) var2993)
(declare-fun var324_add/-1142548109 (var324 var1793) Bool)
(declare-fun cast-from-var117-to-var324 (var117) var324)
(declare-fun cast-from-String-to-var1793 (String) var1793)
(declare-fun var1476_join/-1761706667 (var2993 String) String)
(declare-fun cast-from-var117-to-var2993 (var117) var2993)
(declare-fun var3551_setHeader/825977769 (var3551 String String) void)
(declare-const null-var3551 var3551)
(declare-const null-var2528 var2528)
(declare-const var3044 var3551) ; Statement: r0 := @parameter0: org.apache.dubbo.remoting.http12.HttpResponse 
(assert (not (= var3044 null-var3551)))
(define-const var1868 var2528 (var3551_headerValues/-959957846 var3044 (cast-from-String-to-String "vary"))) ; Statement: r1 = interfaceinvoke r0.<org.apache.dubbo.remoting.http12.HttpResponse: java.util.List headerValues(java.lang.CharSequence)>("vary") 
 ; Statement: if r1 != null goto $r2 = new java.util.LinkedHashSet 
(assert (not (= var1868 null-var2528))) ; Cond: r1 != null 
(define-const var1794 var117 var117-init) ; Statement: $r2 = new java.util.LinkedHashSet 
(assert true)
;(assert (<init>/22626498 var1794 (cast-from-var2528-to-var2993 var1868))) ; Statement: specialinvoke $r2.<java.util.LinkedHashSet: void <init>(java.util.Collection)>(r1) 

(declare-const var1794!1 var117)
(declare-const var1868!1 var2528)
;(assert (var324_add/-1142548109 (cast-from-var117-to-var324 var1794!1) (cast-from-String-to-var1793 "origin"))) ; Statement: interfaceinvoke $r2.<java.util.Set: boolean add(java.lang.Object)>("origin") 

(declare-const var1794!2 var117)
(declare-const var2145 String)
;(assert (var324_add/-1142548109 (cast-from-var117-to-var324 var1794!2) (cast-from-String-to-var1793 "access-control-request-method"))) ; Statement: interfaceinvoke $r2.<java.util.Set: boolean add(java.lang.Object)>("access-control-request-method") 

(declare-const var1794!3 var117)
(declare-const var537 String)
;(assert (var324_add/-1142548109 (cast-from-var117-to-var324 var1794!3) (cast-from-String-to-var1793 "access-control-request-headers"))) ; Statement: interfaceinvoke $r2.<java.util.Set: boolean add(java.lang.Object)>("access-control-request-headers") 

(declare-const var1794!4 var117)
(declare-const var1587 String)
(define-const var1382 String (var1476_join/-1761706667 (cast-from-var117-to-var2993 var1794!4) ", ")) ; Statement: r3 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: java.lang.String join(java.util.Collection,java.lang.String)>($r2, ", ") 
(assert true) ; Non Conditional
;(assert (var3551_setHeader/825977769 var3044 (cast-from-String-to-String "vary") var1382)) ; Statement: interfaceinvoke r0.<org.apache.dubbo.remoting.http12.HttpResponse: void setHeader(java.lang.CharSequence,java.lang.String)>("vary", r3) 

(declare-const var3044!1 var3551)
(declare-const var867 String)
(declare-const var1382!1 String)
 ; Statement: return 
(check-sat)
; {var3551_headerValues/-959957846=([org.apache.dubbo.remoting.http12.HttpResponse, java.lang.CharSequence], java.util.List), cast-from-String-to-String=([java.lang.String], java.lang.CharSequence), var117-init=([], java.util.LinkedHashSet), <init>/22626498=([java.util.LinkedHashSet, java.util.Collection], void), cast-from-var2528-to-var2993=([java.util.List], java.util.Collection), var324_add/-1142548109=([java.util.Set, java.lang.Object], boolean), cast-from-var117-to-var324=([java.util.LinkedHashSet], java.util.Set), cast-from-String-to-var1793=([java.lang.String], java.lang.Object), var1476_join/-1761706667=([java.util.Collection, java.lang.String], java.lang.String), cast-from-var117-to-var2993=([java.util.LinkedHashSet], java.util.Collection), var3551_setHeader/825977769=([org.apache.dubbo.remoting.http12.HttpResponse, java.lang.CharSequence, java.lang.String], void)}
; {var3551=org.apache.dubbo.remoting.http12.HttpResponse, var3044=r0, var2528=java.util.List, var1868=r1, var117=java.util.LinkedHashSet, var1794=$r2, var2993=java.util.Collection, var324=java.util.Set, var1793=java.lang.Object, var2145="origin", var537="access-control-request-method", var1587="access-control-request-headers", var1476=org.apache.dubbo.common.utils.StringUtils, var1382=r3, var867="vary"}
; {org.apache.dubbo.remoting.http12.HttpResponse=var3551, r0=var3044, java.util.List=var2528, r1=var1868, java.util.LinkedHashSet=var117, $r2=var1794, java.util.Collection=var2993, java.util.Set=var324, java.lang.Object=var1793, "origin"=var2145, "access-control-request-method"=var537, "access-control-request-headers"=var1587, org.apache.dubbo.common.utils.StringUtils=var1476, r3=var1382, "vary"=var867}
;seq <org.apache.dubbo.common.utils.StringUtils: java.lang.String join(java.util.Collection,java.lang.String)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: java.lang.String join(java.util.Collection,java.lang.String)>": 1}
;stmts r0 := @parameter0: org.apache.dubbo.remoting.http12.HttpResponse;	r1 = interfaceinvoke r0.<org.apache.dubbo.remoting.http12.HttpResponse: java.util.List headerValues(java.lang.CharSequence)>("vary");	if r1 != null goto $r2 = new java.util.LinkedHashSet;	$r2 = new java.util.LinkedHashSet;	specialinvoke $r2.<java.util.LinkedHashSet: void <init>(java.util.Collection)>(r1);	interfaceinvoke $r2.<java.util.Set: boolean add(java.lang.Object)>("origin");	interfaceinvoke $r2.<java.util.Set: boolean add(java.lang.Object)>("access-control-request-method");	interfaceinvoke $r2.<java.util.Set: boolean add(java.lang.Object)>("access-control-request-headers");	r3 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: java.lang.String join(java.util.Collection,java.lang.String)>($r2, ", ");	interfaceinvoke r0.<org.apache.dubbo.remoting.http12.HttpResponse: void setHeader(java.lang.CharSequence,java.lang.String)>("vary", r3);	return
;block_num 3