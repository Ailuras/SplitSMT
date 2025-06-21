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

(declare-sort var1483 0)
(declare-sort var104 0)
(declare-sort var661 0)
(declare-sort var3160 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var661_getAttachment/-2134772037 (var661 String) String)
(declare-fun var3160_isNotEmpty/-1251449450 (String) Bool)
(declare-const null-var1483 var1483)
(declare-const null-var104 var104)
(declare-const null-var661 var661)
(declare-const var3010 var1483) ; Statement: r9 := @this: org.apache.dubbo.rpc.filter.ProfilerServerFilter 
(assert (not (= var3010 null-var1483)))
(declare-const var3557 var104) ; Statement: r7 := @parameter0: org.apache.dubbo.rpc.Result 
(assert (not (= var3557 null-var104)))
(declare-const var537 var661) ; Statement: r0 := @parameter1: org.apache.dubbo.rpc.Invocation 
(assert (not (= var537 null-var661)))
(define-const var339 String (var661_getAttachment/-2134772037 var537 "lb_adaptive")) ; Statement: r1 = interfaceinvoke r0.<org.apache.dubbo.rpc.Invocation: java.lang.String getAttachment(java.lang.String)>("lb_adaptive") 
(define-const var1375 Bool (var3160_isNotEmpty/-1251449450 var339)) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>(r1) 
 ; Statement: if $z0 == 0 goto return 
(assert (= (ite var1375 1 0) 0)) ; Cond: $z0 == 0 
 ; Statement: return 
(check-sat)
; {var661_getAttachment/-2134772037=([org.apache.dubbo.rpc.Invocation, java.lang.String], java.lang.String), var3160_isNotEmpty/-1251449450=([java.lang.String], boolean)}
; {var1483=org.apache.dubbo.rpc.filter.ProfilerServerFilter, var3010=r9, var104=org.apache.dubbo.rpc.Result, var3557=r7, var661=org.apache.dubbo.rpc.Invocation, var537=r0, var339=r1, var3160=org.apache.dubbo.common.utils.StringUtils, var1375=$z0}
; {org.apache.dubbo.rpc.filter.ProfilerServerFilter=var1483, r9=var3010, org.apache.dubbo.rpc.Result=var104, r7=var3557, org.apache.dubbo.rpc.Invocation=var661, r0=var537, r1=var339, org.apache.dubbo.common.utils.StringUtils=var3160, $z0=var1375}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>": 1}
;stmts r9 := @this: org.apache.dubbo.rpc.filter.ProfilerServerFilter;	r7 := @parameter0: org.apache.dubbo.rpc.Result;	r0 := @parameter1: org.apache.dubbo.rpc.Invocation;	r1 = interfaceinvoke r0.<org.apache.dubbo.rpc.Invocation: java.lang.String getAttachment(java.lang.String)>("lb_adaptive");	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>(r1);	if $z0 == 0 goto return;	return
;block_num 2